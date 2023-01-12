const express = require("express");

const authRouter = express.Router();

authRouter.get("/api/signup", (req, res) => {
    res.json({name:"Dhruv"});
});

module.exports = authRouter;