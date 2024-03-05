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

export interface Dish {
  name: string;
  ingredients : [];
  // ing + portions 
}

export interface Dish_id extends Dish {
  _id: ObjectId;
}

export interface Campaign {
  name: string;
  dishes: json;
  target: number;
  usedIngredients: json;
  stationLeaders: String[];
  facilitators: String[];
  activated: boolean;
  report:[];
}

export interface Campaign_id extends Campaign {
  _id: ObjectId;
}
