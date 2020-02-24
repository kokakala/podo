package com.ch.podo.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InfoController {

	@RequestMapping("termsofuse.do")
	public String termsOfUse() {
		return "common/termsOfUseForm";
	}

	@RequestMapping("privacyPolicy.do")
	public String privacyPolicy() {
		return "common/privacyPolicyForm";
	}

	@RequestMapping("faq.do")
	public String faq() {
		return "common/faqForm";
	}

}
