package com.ch.podo.member.controller;

import java.util.Optional;

import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ch.podo.member.model.service.MemberService;
import com.ch.podo.member.model.vo.UnblockRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController // @Controller + @ResponseBody
@RequestMapping("/v1/blacklist")
public class BlackListAPIController {
	private final MemberService memberService;
	
	public BlackListAPIController(MemberService memberService) {
		this.memberService = memberService;
	}

	@PostMapping(value = "/unblock.do")
	// @ResponseBody
	public boolean unblock(@RequestBody UnblockRequest unblockRequest) throws Exception {
		String[] blockIds = Optional.ofNullable(unblockRequest) // 자바8 optional 사용 -> nullpointexception 방지를 막음
									.map(UnblockRequest::getBlockIds)
									.orElse(null);
		
		if (blockIds == null || (blockIds != null && blockIds.length == 0)) {
			return false;
		}
		
		log.info("blockIds : {}", blockIds);
 
		int result = memberService.deleteBlackMember(blockIds);
		
		if(result>0) {
			return true;
			
		}else {
			return false;
		}
		
//		return true;
	}
}
