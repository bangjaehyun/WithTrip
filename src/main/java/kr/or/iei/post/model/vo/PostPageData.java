package kr.or.iei.post.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class PostPageData {
	private ArrayList<Post> list;
	private String pageNavi;
}
