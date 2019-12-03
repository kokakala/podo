package com.ch.podo.report.controller;
import java.util.ArrayList;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ch.podo.report.model.service.ReportService;
import com.ch.podo.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController // @Controller + @ResponseBody
@RequestMapping("/v1/reportList")
public class ReportAPIController {
	private final ReportService reportService;
	
	public ReportAPIController(ReportService reportService) {
		this.reportService = reportService;
	}

	@PostMapping(value = "/blind.do")
	@ResponseBody
	public boolean blind(String targetId, String type, String[] checked) throws Exception {

		System.out.println(targetId + " " + type);
		log.info("checked : " + checked);

		ArrayList<Report> r = new ArrayList<>();
		
		if (targetId != null && type != null) {
			Report re = new Report();
			re.setTargetId(Integer.parseInt(targetId));
			re.setType(Integer.parseInt(type));
			r.add(re);
		}
		
		if(checked != null) {
			for (int i = 0; i < checked.length; i+=2) {
				if (i % 2 == 0) {
					Report re = new Report();
					re.setTargetId(Integer.parseInt(checked[i]));
					re.setType(Integer.parseInt(checked[i+1]));
					r.add(re);
				}
			}
		}
		

		System.out.println(r);
		
		int result = reportService.blindReport(r);
		
		if (result > 0) {
			return true;
		} else {
			return false;
		}
	}
}