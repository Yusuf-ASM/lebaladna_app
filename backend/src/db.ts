import { MongoClient, MongoServerError, ObjectId } from "mongodb";
import {
  Campaign,
  Campaign_id,
  Ingredient,
  IngredientRequest,
  Ingredient_id,
  Meal,
  Meal_id,
  User,
  User_id,
  json,
} from "schema";
import { generateToken, getDate, getDateEpoch, hashPassword } from "./utility";

require("dotenv").config();

const mongoUrl = process.env.MONGOLINK as string;
const dbName = process.env.DBNAME as string;

const mongoClient = new MongoClient(mongoUrl);
let db = mongoClient.db(dbName);

const usersCollection = db.collection("users");
const ingredientsCollection = db.collection("ingredients");
const mealsCollection = db.collection("meals");
const campaignsCollection = db.collection("campaigns");

let ingredientsCache: json = {};
let usersCache: json = {};

//okie
export async function createIndexes() {
  await usersCollection.createIndex("name", { unique: true });
  await ingredientsCollection.createIndex("name", { unique: true });
  await mealsCollection.createIndex("name", { unique: true });

  await campaignsCollection.createIndex("stationLeaders");
  await campaignsCollection.createIndex("kitchenLeader");
  await campaignsCollection.createIndex("facilitators");
}

export async function cache() {
  await cacheIngredients();
  await cacheUsers();
}
///////////////////////////////////////////////////////////////////////////////////////////

//okie
export async function login({ name, password }: { name: string; password: string }) {
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

//okie
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

//okie
async function cacheUsers() {
  let users = (await usersCollection.find().toArray()) as User_id[];

  for (const user of users) {
    usersCache[user._id.toString()] = user.name;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

//okie
export async function registerIngredient({
  name,
  measureUnit,
}: {
  name: string;
  measureUnit: string;
}) {
  let ingredient: Ingredient = {
    name: name,
    measureUnit: measureUnit,
  };
  try {
    let ingredientResult = await ingredientsCollection.insertOne(ingredient);
    return ingredientResult.acknowledged;
  } catch (error) {
    if (error instanceof MongoServerError) {
      if (error.code == 11000) {
        return [406, "Ingredient exists."];
      }
    }
    return [500, "DB error."];
  }
}

//okie
export async function getIngredients() {
  let ingredients = (await ingredientsCollection.find().toArray()) as Ingredient_id[];
  let names = [];
  for (const ingredient of ingredients) {
    names.push(ingredient.name);
  }
  return [names, ingredients];
}

//okie
export async function addIngredient({
  campaignId,
  quantity,
  plate,
  ingredient,
}: {
  campaignId: string;
  userId: string;
  quantity: number;
  plate: number;
  ingredient: string;
}) {
  const query = { _id: new ObjectId(campaignId) };
  const res = await campaignsCollection.updateOne(query, {
    $inc: {
      ["repo." + ingredient]: plate,
      ["kitchenReport." + ingredient + ".plate"]: plate,
      ["kitchenReport." + ingredient + "." + ingredientsCache[ingredient]]: quantity,
    },
  });
  console.log(res);
}

export async function requestIngredient({
  campaignId,
  stationId,
  ingredient,
  quantity,
}: {
  campaignId: string;
  stationId: string;
  ingredient: string;
  quantity: number;
}) {
  const query = { _id: new ObjectId(campaignId) };
  const request: IngredientRequest = {
    ingredient,
    quantity,
    stationId: new ObjectId(stationId),
    date: getDateEpoch(),
  };
  const res = await campaignsCollection.updateOne(query, { $push: { requests: request } });
  console.log(res);
}

//okie
async function cacheIngredients() {
  let ingredients = (await ingredientsCollection.find().toArray()) as Ingredient_id[];

  for (const ingredient of ingredients) {
    ingredientsCache[ingredient.name] = ingredient.measureUnit;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////

//okie
export async function registerMeal({
  name,
  ingredients,
}: {
  name: string;
  ingredients: Ingredient[];
}) {
  let meal: Meal = {
    name: name,
    ingredients: ingredients,
    target: 0,
    cooked: 0,
  };
  try {
    let mealResult = await mealsCollection.insertOne(meal);
    return mealResult.acknowledged;
  } catch (error) {
    if (error instanceof MongoServerError) {
      if (error.code == 11000) {
        return [406, "Meal exists."];
      }
    }
    return [500, "DB error."];
  }
}

//okie
export async function getMeals() {
  let meals = (await mealsCollection.find().toArray()) as Meal_id[];
  let names = [];
  for (const meal of meals) {
    names.push(meal.name);
  }
  return [names, meals];
}

export async function addMeal({
  campaignId,
  name,
  quantity,
  meal,
}: {
  campaignId: string;
  name: string;
  quantity: number;
  meal: string;
}) {
  console.log(name);
  console.log(meal);
  const query = { _id: new ObjectId(campaignId) };
  const res = await campaignsCollection.updateOne(query, {
    // $set: {
    //   [`stationReport.${name}.meals`]: {
    //     [meal]: quantity,
    //   },
    // },
    $inc: { [`meals.${meal}.cooked`]: quantity, [`stationsReport.${name}.meals.${meal}`]: quantity },
  });
  console.log(res);
}

///////////////////////////////////////////////////////////////////////////////////////////

//okie
export async function registerCampaign({
  name,
  stationLeaders,
  kitchenLeader,
  meals,
}: {
  name: string;
  stationLeaders: string[];
  kitchenLeader: string;
  meals: { [key: string]: Meal_id };
}) {
  let stationReport: json = {};
  let mealNames: json = {};
  let ingredientNames: json = {};
  for (const meal in meals) {
    const name = meals[meal].name;
    mealNames[name] = 0;
    for (const ingredient of meals[meal].ingredients) {
      ingredientNames[ingredient.name] = 0;
    }
  }
  for (const leader of stationLeaders) {
    stationReport[usersCache[leader]] = {
      meals: mealNames,
      ingredients: ingredientNames,
    };
  }
  let campaign: Campaign = {
    name: name,
    meals: meals,
    kitchenLeader: kitchenLeader,
    stationLeaders: stationLeaders,
    stationsReport: stationReport,
    kitchenReport: {},
    facilitators: [],
    activated: true,
    repo: {},
    requests: [],
  };
  try {
    let mealResult = await campaignsCollection.insertOne(campaign);
    return mealResult.acknowledged;
  } catch (error) {
    if (error instanceof MongoServerError) {
      if (error.code == 11000) {
        return [406, "Meal exists."];
      }
    }
    return [500, "DB error."];
  }
}

export async function getUserCampaigns({ _id, activated }: { _id: string; activated: boolean }) {
  const userId = new ObjectId(_id);
  const query = {
    activated: activated,
    $or: [{ kitchenLeader: _id }, { facilitators: _id }, { stationLeaders: _id }],
  };

  let campaigns = (await campaignsCollection.find(query).toArray()) as Campaign_id[];
  let result = [];
  let temp = [];

  for (const campaign of campaigns) {
    temp = [campaign._id, campaign.name];

    if (campaign.kitchenLeader == _id) {
      temp.push("kitchen");
    } else if (campaign.facilitators.includes(_id)) {
      temp.push("facilitator");
    } else if (campaign.stationLeaders.includes(_id)) {
      temp.push("station");
    }

    result.push(temp);
  }

  return result;
}

export async function getCampaign(_id: string) {
  const query = { _id: new ObjectId(_id) };
  let result = await campaignsCollection.findOne<Campaign_id>(query);
  return result;
}

// export async function getCampaignMeals(_id: string) {
//   const query = { _id: new ObjectId(_id) };
//   let result = await campaignsCollection.findOne<Campaign_id>(query);
//   let output=[];
//   if (result!=null) {
//     for (const key in result.meals) {

//     }
//    return output
//   }
//   return result;
// }
///////////////////////////////////////////////////////////////////////////////////////////

export async function getStationProgress({
  campaignId,
  stationName,
}: {
  campaignId: string;
  stationName: string;
}) {
  const query = { _id: new ObjectId(campaignId) };
  let result = await campaignsCollection.findOne<Campaign_id>(query);
  if (result != null) {
    return result.stationsReport[stationName];
  }
  return null;
}

///////////////////////////////////////////////////////////////////////////////////////////

export async function getKitchenProgress({ campaignId }: { campaignId: string }) {
  const query = { _id: new ObjectId(campaignId) };
  let result = await campaignsCollection.findOne<Campaign_id>(query);
  if (result != null) {
    return result.kitchenReport;
  }
  return null;
}

// export async function authenticateUser({ _id, token }: { _id: string; token: string }) {
//   const query = { _id: new ObjectId(_id), token: { $in: [token] } };
//   let user = await usersCollection.findOne<User>(query);
//   return user;
// }

// export async function deleteUser(_id: string) {
//   const query = { _id: new ObjectId(_id) };
//   let result = await usersCollection.deleteOne(query);
//   return result.acknowledged && result.deletedCount == 1;
// }

// export async function modifyUserData({ _id, data }: { _id: string; data: json }) {
//   const query = { _id: new ObjectId(_id) };
//   let result = await usersCollection.updateOne(query, {
//     $set: data,
//   });
//   return result.acknowledged && result.modifiedCount == 1;
// }

///////////////////////////////////////////////////////////////////////////////////////////

setInterval(async () => await cache(), 60 * 1000);
