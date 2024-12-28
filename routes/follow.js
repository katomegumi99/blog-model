const express = require('express');
const router = express.Router();
const {follow,unfollow,getFollowings,getFollowers} = require("../models/follow");


router.post("/addFollow", async (req, res) => {
    console.log("router: /addFollow", req.body);
    let {userId, followId} = req.body;
    try {
        const result = await follow(userId, followId);
        res.json({
            code: 200,
            message: '关注成功',
            data: result
        })
    }catch (error) {
        res.json({
            code: 500,
            message: '关注失败',
            data: error
        })
    }
});

router.post("/getFollowings", async (req, res) => {
    console.log("router: /getFollowings", req.body);
    let {userId} = req.body;
    try {
        const result = await getFollowings(userId);
        res.json({
            code: 200,
            message: '获取关注列表成功',
            data: result
        })
    }catch (error) {
        res.json({
            code: 500,
            message: '获取关注列表失败',
            data: error
        })
    }
});

router.post("/getFollowers", async (req, res) => {
    console.log("router: /getFollowers", req.body);
    let {userId} = req.body;
    try {
        const result = await getFollowers(userId);
        res.json({
            code: 200,
            message: '获取粉丝列表成功',
            data: result
        })
    }catch (error) {
        res.json({
            code: 500,
            message: '获取粉丝列表失败',
            data: error
        })
    }
});

module.exports = router;