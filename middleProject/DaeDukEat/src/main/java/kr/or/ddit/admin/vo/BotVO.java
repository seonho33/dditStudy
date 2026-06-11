package kr.or.ddit.admin.vo;

public class BotVO {

	private int botId; /*  */
	private String categoryName; /* 질문카테고리 */
	private String questionKeyword; /* 사용자에게 보여질 질문 문구 */
	private String answerContent; /* 봇의 자동 응답 내용 */
	private String activeYn; /* 활성화여부(Y,N) */
	private String userId; /* 이용자아이디 */
	
	
	public int getBotId() {
		return botId;
	}
	public void setBotId(int botId) {
		this.botId = botId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getQuestionKeyword() {
		return questionKeyword;
	}
	public void setQuestionKeyword(String questionKeyword) {
		this.questionKeyword = questionKeyword;
	}
	public String getAnswerContent() {
		return answerContent;
	}
	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}
	public String getActiveYn() {
		return activeYn;
	}
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "BotVO [botId=" + botId + ", categoryName=" + categoryName + ", questionKeyword=" + questionKeyword
				+ ", answerContent=" + answerContent + ", activeYn=" + activeYn + ", userId=" + userId + "]";
	}
	
	
}
