import { MongoClient } from "mongodb";

require("dotenv").config();

const mongoUrl = process.env.TESTINGMONGOLINK as string;
const dbName = process.env.DBNAME as string;

const mongoClient = new MongoClient(mongoUrl);
let db = mongoClient.db(dbName);

const usersCollection = db.collection("users");

export async function createIndexes() {
  await usersCollection.createIndex("name");
}
