
const express = require("express");
const router = express.Router();
const upload = require('../controller/products.controller');
const authToken = require('../middleware/authToken')


router.get('/upload',[authToken.verifyToken], upload.get_upload);
router.post('/', upload.add_upload);
router.get('/',  upload.all_upload);
router.delete('/:id',  upload.delete_upload);
router.patch('/:id', upload.edit_upload);


module.exports = router;
