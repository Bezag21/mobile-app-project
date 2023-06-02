const express = require('express');
const inspection = require('../controller/inspection.controller');
const router = express.Router();
const authToken = require('../middleware/authToken')

router.get('/inspection',[authToken.verifyToken], inspection.get_inspection);
router.post('/', inspection.add_inspection);
router.get('/', inspection.all_inspection);
router.delete('/:id', inspection.delete_inspection);
router.patch('/:id',inspection.edit_inspection);




module.exports = router