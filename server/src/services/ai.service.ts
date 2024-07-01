import { GoogleGenerativeAI } from "@google/generative-ai";
import { JudgeRequest, JudgeResponse } from "../models/judge.model";

const apiKey = process.env.GEMINI_API_KEY;
if (!apiKey) {
  throw new Error(
    "GEMINI_API_KEY is not defined in the environment variables."
  );
}
const genAI = new GoogleGenerativeAI(apiKey);

export const generateJudge = async (
  judgeRequest: JudgeRequest
): Promise<JudgeResponse> => {
  const prompt = `
  あなたは、お笑い番組の大喜利バトル「IPPON」審査員です。お笑いには識見と評判が高いです。以下の回答を審査してください。
  scoreは100点満点でお願いします。
  
  - お題: ${judgeRequest.question}
  - 回答: ${judgeRequest.answer}

  - 審査条件
  1. 各解答に対し、審査コメントと点数を以下のようなJSON形式で返事してください。
  {
    "userName": "${judgeRequest.userName}",
    "question": "${judgeRequest.question}",
    "answer": "${judgeRequest.answer}",
    "comment": "短く面白い審査コメントをここに",
    "score": 0
  }
  2. 審査コメントは面白く、簡潔に一言でお願いします
  
  回答:
  {
    "userName": "${judgeRequest.userName}",
    "question": "${judgeRequest.question}",
    "answer": "${judgeRequest.answer}",
    "comment": "短く面白い審査コメントをここに",
    "score": 0
  }
  `;

  const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash-latest" });
  const result = await model.generateContent(prompt);
  const response = result.response;
  const text = response.text();

  const trimmedText = text.trim();
  const startIndex = trimmedText.indexOf("{");
  const endIndex = trimmedText.lastIndexOf("}") + 1;
  const jsonResponse = trimmedText.substring(startIndex, endIndex);

  console.log("Generated text:", text);

  try {
    const judgeResponse: JudgeResponse = JSON.parse(jsonResponse);
    return judgeResponse;
  } catch (error) {
    console.error("Error parsing JSON:", error);
    console.error("Generated text:", jsonResponse);
    throw new Error("Failed to parse the generated response as JSON");
  }
};
