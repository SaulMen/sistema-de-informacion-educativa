const express = require('express');
const router = express.Router();

const { modelo } = require('../controllers/crearModelo');
const { eliminar } = require('../controllers/eliminarModelo');
const { temporales } = require('../controllers/datosTemp');
const { consulta1 } = require('../controllers/consultaUno');
const { consulta2 } = require('../controllers/consultaDos');
const { consulta3 } = require('../controllers/consultaTres');
const { consulta4 } = require('../controllers/consultaCuatro');
const { consulta5 } = require('../controllers/consultaCinco');
const { consulta6 } = require('../controllers/consultaSeis');
const { consulta7 } = require('../controllers/consultaSiete');
const { consulta8 } = require('../controllers/consultaOcho');
const { consulta9 } = require('../controllers/consultaNueve');
const { consulta10 } = require('../controllers/consultaDiez');
const { consulta11} = require('../controllers/consultaOnce');


router.get('/crearmodelo', modelo)
router.get('/eliminarmodelo', eliminar)
router.get('/cargartemporales', temporales)
router.get('/consulta1', consulta1)
router.get('/consulta2', consulta2)
router.get('/consulta3', consulta3)
router.get('/consulta4', consulta4)
router.get('/consulta5', consulta5)
router.get('/consulta6', consulta6)
router.get('/consulta7', consulta7)
router.get('/consulta8', consulta8)
router.get('/consulta9', consulta9)
router.get('/consulta10', consulta10)
router.get('/consulta11', consulta11)


module.exports = router;
