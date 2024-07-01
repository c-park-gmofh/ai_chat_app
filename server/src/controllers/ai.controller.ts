import { Request, Response } from 'express';
import * as aiService from '../services/ai.service';
import { JudgeRequest } from '../models/judge.model';

export const generateJudge = async (req: Request, res: Response): Promise<void> => {
  const judgeRequest: JudgeRequest = req.body;
  try {
    const judgeResponse = await aiService.generateJudge(judgeRequest);
    res.json(judgeResponse);
  } catch (error) {
    console.log("error : ", error);
    res.status(500).send('Error generating AI response');
  }
};
