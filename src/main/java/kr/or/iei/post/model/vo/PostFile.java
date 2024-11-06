package kr.or.iei.post.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class PostFile {
	private String fileNo; 		//분류번호
	private String postNo;		//어떤 게시글에 있는 파일인지
	private String fileName;
	private String filePath;
}
