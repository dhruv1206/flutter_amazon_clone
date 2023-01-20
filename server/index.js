// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");

// INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://dhruv1206:dhruv_1206@cluster0.lhwdagb.mongodb.net/?retryWrites=true&w=majority";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

mongoose.connect(DB).then(() => {
  console.log("Connection successfull with MongoDB");
}).catch((e)=>{
  console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});