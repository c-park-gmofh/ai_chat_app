export interface JudgeRequest {
  userName: string;
  question: string;
  answer: string;
}

export interface JudgeResponse {
  userName: string;
  question: string;
  answer: string;
  comment: string;
  score: number;
}
