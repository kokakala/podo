package podo;

import java.util.Locale;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ch.podo.common.config.MessageConfig;

import lombok.extern.slf4j.Slf4j;

import static junit.framework.Assert.*;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {MessageConfig.class})
public class MessageSourceTest {
	private static final String MESSAGE_CODE = "authentication.error";
	private static final String DEFAULT_LOCALE_MESSAGE = "로그인해 주세요.";
	private static final String KOREA_LOCALE_MESSAGE = "로그인해 주세요.";
	private static final String ENGLISH_LOCALE_MESSAGE = "Please Sign in.";

	@Autowired
	private MessageSource messageSource;

	@Test
	public void getDefaultMessageTest() {
		String message = messageSource.getMessage(MESSAGE_CODE, null, Locale.getDefault());
		log.debug("Default locale message: {}", message);
		assertEquals(DEFAULT_LOCALE_MESSAGE, message);
	}

	@Test
	public void getMessageByKoreanTest() {
		String message = messageSource.getMessage(MESSAGE_CODE, null, Locale.KOREAN);
		log.debug("Korean message: {}", message);
		assertEquals(KOREA_LOCALE_MESSAGE, message);
	}
	
	@Test
	public void getMessageByEnglishTest() {
		String message = messageSource.getMessage(MESSAGE_CODE, null, Locale.ENGLISH);
		log.debug("English message: {}", message);
		assertEquals(ENGLISH_LOCALE_MESSAGE, message);
	}
}