import { Request, Response } from "express";
import * as db from "../helper/db";
import * as utility from "../helper/utility";
import Joi from "joi";
import { notify } from "../helper/backend";

export async function addIngredientBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }
  const checkingResult = utility.checkParameter({
    body: body,
    objectIds: ["campaignId"],
    numbers: ["quantity", "plate"],
    strings: ["ingredient"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.addIngredient(body);
    await notify("kitchen");
    console.log(result);
    res.send(result);
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}

export async function getKitchenProgressBackend(req: Request, res: Response) {
  const body = req.body;

  if (Object.keys(body).length == 0) {
    res.status(400).send({ error: "Empty Body" });
    return;
  }
  const checkingResult = utility.checkParameter({
    body: body,
    objectIds: ["campaignId"],
  });

  if (checkingResult[0] == 200) {
    let result = await db.getKitchenProgress(body);
    console.log(result);
    if (result != null) {
      res.send(result);
    } else {
      res.status(404).send({ error: "Not Found" });
    }
  } else {
    res.status(checkingResult[0]).send({ error: checkingResult[1] });
  }
}
