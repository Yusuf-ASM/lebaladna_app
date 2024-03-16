import * as crypto from "crypto";
import { ObjectId } from "mongodb";
require("dotenv").config();

const TokenLength = Number(process.env.TOKENLENGTH);
const TelecomCompaniesNumbers = ["0", "1", "2", "5"];

//okie
export function hashPassword(password: string): string {
  let hashedPassword = crypto.createHmac("sha256", password).digest().toString("hex");
  return hashedPassword;
}

//okie
export function generateToken() {
  return crypto.randomBytes(TokenLength).toString("hex");
}

//okie
export function checkPassword({
  requestPassword,
  hashedPassword,
}: {
  requestPassword: string;
  hashedPassword: string;
}): boolean {
  requestPassword = crypto.createHmac("sha256", requestPassword).digest().toString("hex");
  return requestPassword === hashedPassword;
}

//okie
export function isValidEmail(email: string): boolean {
  let splittedEmail = email.split("@");
  if (splittedEmail.length === 2 && splittedEmail[0] !== "" && splittedEmail[1] !== "") {
    return true;
  }
  return false;
}

//okie
export function isValidNuEmail(email: string): boolean {
  if (isValidEmail(email) && email.split("@")[1] === "nu.edu.eg") {
    return true;
  }
  return false;
}

//okie
export function isInt(text: string): Boolean {
  return /^\d+$/.test(text);
}

//okie
export function isValidPhoneNumber(phoneNumber: string): boolean {
  if (phoneNumber.length == 11 && isInt(phoneNumber)) {
    if (
      phoneNumber[0] == "0" &&
      phoneNumber[1] == "1" &&
      TelecomCompaniesNumbers.includes(phoneNumber[2])
    ) {
      return true;
    }
  }
  return false;
}

async function encrypt() {
  const algorithm = "aes-192-gcm";
  const password = "Password used to generate key";

  const key = crypto.scryptSync(password, "salt", 24);
  let iv = new Uint8Array(16);
  crypto.randomFillSync(iv);
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  let encrypted = cipher.update("some clear text data0", "utf8", "hex");
  encrypted += cipher.final("hex");
  const authTag = cipher.getAuthTag();
  return [encrypted, iv, authTag];
}

async function decrypt(en: string, iv: Uint8Array, auth: Buffer) {
  const algorithm = "aes-192-gcm";
  const password = "Password used to generate key";

  const key = crypto.scryptSync(password, "salt", 24);

  const cipher = crypto.createDecipheriv(algorithm, key, iv);
  cipher.setAuthTag(auth);
  let encrypted = cipher.update(en, "hex", "utf8");
  encrypted += cipher.final("utf8");
  return encrypted;
}

//okie
export function isValidObjectId(id: string) {
  if (ObjectId.isValid(id)) {
    if (new ObjectId(id).toString() === id) return true;
  }
  return false;
}

//okie
export function getDate(fullDate = false) {
  let date = new Date().toLocaleString("en-za", { timeZone: "Africa/Cairo" });
  if (fullDate) {
    return date;
  }
  return date.split(",")[0].replaceAll("/", "-");
}

//okie
export function getDateEpoch() {
  let date = new Date(getDate()).getTime();
  return Math.floor(date / 1000);
}

//separate type checking from object key checking
export function checkParameter({
  body,
  strings = [],
  numbers = [],
  booleans = [],
  objectIds = [],
  constants = [],
  jsons = {},
  arrays = [],
}: {
  body: { [key: string]: any };
  strings?: string[];
  numbers?: string[];
  booleans?: string[];
  objectIds?: string[];
  constants?: (any | any[])[][];
  jsons?: { [key: string]: (string | string[])[][] };
  arrays?: any[][];
}): [number, string] {
  if (strings.length != 0) {
    for (const key of strings) {
      if (!body.hasOwnProperty(key) || body[key] === "") {
        return [400, "Missing " + key];
      } else if (typeof body[key] !== "string") {
        return [400, "Invalid  " + key];
      }
    }
  }

  if (numbers.length != 0) {
    for (const key of numbers) {
      if (!body.hasOwnProperty(key)) {
        return [400, "Missing " + key];
      } else if (typeof body[key] !== "number" || body[key] < 0) {
        return [400, "Invalid  " + key];
      }
    }
  }

  if (booleans.length != 0) {
    for (const key of booleans) {
      if (!body.hasOwnProperty(key)) {
        return [400, "Missing " + key];
      } else if (typeof body[key] !== "boolean") {
        return [400, "Invalid  " + key];
      }
    }
  }

  if (objectIds.length != 0) {
    for (const key of objectIds) {
      if (!body.hasOwnProperty(key)) {
        return [400, "Missing " + key];
      } else if (typeof body[key] !== "string" || !isValidObjectId(body[key])) {
        return [400, "Invalid  " + key];
      }
    }
  }

  if (Object.keys(jsons).length != 0) {
    for (const json in jsons) {
      let strings: any[] = [];
      let numbers: any[] = [];
      let booleans: any[] = [];

      for (const key of jsons[json]) {
        let isArray = Array.isArray(key[0]);
        if (key[1] === "bool") {
          if (isArray) {
            booleans = booleans.concat(key[0]);
          } else {
            booleans.push(key[0]);
          }
        } else if (key[1] === "str") {
          if (isArray) {
            strings = strings.concat(key[0]);
          } else {
            strings.push(key[0]);
          }
        } else if (key[1] === "num") {
          if (isArray) {
            strings = strings.concat(key[0]);
          } else {
            strings.push(key[0]);
          }
        }
      }

      let checkingResult = checkParameter({
        body: body[json],
        strings,
        numbers,
        booleans,
      });
      if (checkingResult[0] == 400) {
        return checkingResult;
      }
    }
  }

  if (constants.length != 0) {
    for (const constant of constants) {
      const key = constant[0];
      if (!body.hasOwnProperty(key)) {
        return [400, "Missing " + key];
      }
      if (!constant[1].includes(body[key])) {
        return [400, "Invalid " + key];
      }
    }
  }

  if (arrays.length != 0) {
    for (const array of arrays) {
      const key = array[0];
      const type = array[1];
      if (!body.hasOwnProperty(key) || array[2].length == 0) {
        return [400, "Missing " + key];
      }
      for (const element of array[2]) {
        if (typeof element !== "string" || !isValidObjectId(element)) {
          return [400, "Invalid " + key];
        }
      }
    }
  }

  return [200, "okie"];
}

export function isValidDateString(date: string) {
  let splittedDate = date.split("-");
  if (
    splittedDate.length !== 3 ||
    splittedDate[0].length !== 4 ||
    splittedDate[1].length !== 2 ||
    splittedDate[2].length !== 2 ||
    !isInt(splittedDate[0]) ||
    !isInt(splittedDate[1]) ||
    !isInt(splittedDate[2])
  ) {
    return false;
  }

  let dateNumber = splittedDate.map((x) => Number(x));
  let year = dateNumber[0];
  let month = dateNumber[1];
  let day = dateNumber[2];

  if (year < 2020 || year > 2100 || month < 1 || month > 12 || day < 1 || day > 31) {
    return false;
  }

  return true;
}

export function isValidDateNumber(date: number) {
  let dateString = date.toString();
  if (typeof date !== "number" || !isInt(dateString) || dateString.length != 10) {
    return false;
  }
  return date > 1577829600 && date < 4102437600;
}

export function isValidDate(date: string | number) {
  if (typeof date === "string") {
    return isValidDateString(date);
  } else if (typeof date === "number") {
    return isValidDateNumber(date);
  }
  return false;
}

export function delay(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export function joiObjectId(value: any, helper: any) {
  if (isValidObjectId(value)) return value;
  return helper.message("Not a valid ObjectId");
}
