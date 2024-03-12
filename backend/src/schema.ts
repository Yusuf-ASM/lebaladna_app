import { ObjectId } from "mongodb";
import { WebSocket } from "ws";
export type json = { [key: string]: any };

export type WebSocketJson = { [key: string]: WebSocket };

export interface User {
  name: string;
  password: string;
  tokens: [];
}

export interface User_id extends User {
  _id: ObjectId;
}

export interface Ingredient {
  name: string;
  measureUnit: string;
}

export interface Ingredient_id extends Ingredient {
  _id: ObjectId;
}

export interface IngredientRequest {
  stationId: ObjectId;
  ingredient: string;
  quantity: number;
  date: number;
}

export interface Meal {
  name: string;
  ingredients: Ingredient[];
  target: number;
  cooked: number;
}

export interface Meal_id extends Meal {
  _id: ObjectId;
}

export interface Campaign {
  name: string; // okie
  meals: { [key: string]: Meal_id }; // make it json better {rice : [100,prepared], meat : [200,prepared]}
  stationLeaders: string[]; // okie
  kitchenLeader: string; // okie
  facilitators: string[]; // okie
  activated: boolean; // okie
  kitchenReport: json; // kitchen at time x produced y quantity of z ingredient [time, quantity, ]
  stationsReport: json; // {station1:{report:[starttime, wns]}}
  repo: json; // {rice: 10, meat: 2} kitchen leader and leader can see it
  requests: IngredientRequest[];
}

export interface StationReport {
  temp: json;
  report: json;
}

// let Campaign = {
//   s1: {
//     temp :{
//       rice: 15,
//       meat:3
//     },
//     report: {rice:[15,16,564]},
//   },
// };

export interface Campaign_id extends Campaign {
  _id: ObjectId;
}
