import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import dotenv from 'dotenv';

dotenv.config();

import aiRoutes from './routes/ai.route';
import * as aiService from './services/ai.service';
import { JudgeRequest } from './models/judge.model';

const app = express();
const port = 3000;
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: '*',
    methods: ['GET', 'POST'],
  },
});

app.use(express.json());
app.use('/api', aiRoutes);

// health check 
app.get('/', (req, res) => {
  res.send('Server is running!');
});

io.on('connection', (socket) => {
  console.log('a user connected');

  socket.on('message', (msg) => {
    console.log('message: ' + JSON.stringify(msg));
    // 送信元のクライアントには送信しない
    socket.broadcast.emit('message', msg);
  });

  socket.on('judge', async (data) => {
    console.log('judge request: ' + JSON.stringify(data));
    const judgeRequest: JudgeRequest = {
      userName: '審査員',
      question: data.question,
      answer: data.message
    };

    try {
      const judgeResponse = await aiService.generateJudge(judgeRequest);
      io.emit('judgment', judgeResponse);
    } catch (error) {
      console.error('Error generating judgment:', error);
    }
  });

  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
});

server.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});
