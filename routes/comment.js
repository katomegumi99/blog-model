const express = require('express');
const router = express.Router();
const { addComment } = require('../models/comment');

router.post('/addComment', async (req, res) => {

    console.log("route: addComment", req.body);
    try {
        const result = await addComment(req.body);
        res.json({
            code: 200,
            message: '添加评论成功',
            data: result
        })
    } catch (error) {
        res.json({
            code: 500,
            message: '添加评论失败',
            data: error
        })
    }


});

module.exports = router;    