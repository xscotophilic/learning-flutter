import express from "express";
import asyncHandler from "../middleware/asyncHandler.js";
import { googleLogin } from "../controllers/auth.controller.js";

const router = express.Router();

router.post("/google", asyncHandler(googleLogin));

export default router;
