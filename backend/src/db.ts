import { MongoClient, MongoServerError, ObjectId } from "mongodb";
import { User, User_id, json } from "schema";
import { generateToken, hashPassword } from "./utility";

require("dotenv").config();

const mongoUrl = process.env.MONGOLINK as string;
const dbName = process.env.DBNAME as string;

const mongoClient = new MongoClient(mongoUrl);
let db = mongoClient.db(dbName);

const usersCollection = db.collection("users");

export async function createIndexes() {
  await usersCollection.createIndex("name", { unique: true });
}

export async function registerUser({
  name,
  password,
}: {
  name: string;
  password: string;
  permissions: Permissions;
}) {
  let user: User = {
    name: name,
    password: hashPassword(password),
    tokens: [],
  };
  try {
    let userResult = await usersCollection.insertOne(user);
    return userResult.acknowledged;
  } catch (error) {
    if (error instanceof MongoServerError) {
      if (error.code == 11000) {
        return [406, "User exists."];
      }
    }
    return [500, "DB error."];
  }
}

export async function getUsers() {
  let users = (await usersCollection.find().toArray()) as User_id[];
  let names = [];
  let ids = [];
  for (const user of users) {
    names.push(user.name);
    ids.push(user._id);
  }
  return [names, ids];
}

export async function getUser(_id: string) {
  const query = { _id: new ObjectId(_id) };
  let result = await usersCollection.findOne<User_id>(query);
  return result;
}

export async function authenticateUser({
  _id,
  token,
}: {
  _id: string;
  token: string;
}) {
  const query = { _id: new ObjectId(_id), token: { $in: [token] } };
  let user = await usersCollection.findOne<User>(query);
  return user;
}

export async function deleteUser(_id: string) {
  const query = { _id: new ObjectId(_id) };
  let result = await usersCollection.deleteOne(query);
  return result.acknowledged && result.deletedCount == 1;
}

export async function modifyUserData({
  _id,
  data,
}: {
  _id: string;
  data: json;
}) {
  const query = { _id: new ObjectId(_id) };
  let result = await usersCollection.updateOne(query, {
    $set: data,
  });
  return result.acknowledged && result.modifiedCount == 1;
}

export async function login({
  name,
  password,
}: {
  name: string;
  password: string;
}) {
  const query = { name: name, password: hashPassword(password) };
  let user = await usersCollection.findOne<User_id>(query);
  if (user != null) {
    const token = generateToken();

    let result = await usersCollection.updateOne(query, {
      $push: { token: token },
    });

    if (result.acknowledged && result.modifiedCount == 1) {
      return {
        _id: user._id,
        name: user.name,
        token: token,
      };
    }
  }
  return false;
}

///////////////////////////////////////////////////////////////////////////////////////////
