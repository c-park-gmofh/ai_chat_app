import { Router } from 'express';
import * as aiController from '../controllers/ai.controller';

const router = Router();

router.post('/judge', aiController.generateJudge);

export default router;
