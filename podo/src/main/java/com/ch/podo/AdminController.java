package com.ch.podo;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class AdminController {
	
	@RequestMapping("admin.do")
	public ModelAndView home(ModelAndView mv)throws Exception {
		
		mv.setViewName("admin");

		return mv;
	}
	

}
