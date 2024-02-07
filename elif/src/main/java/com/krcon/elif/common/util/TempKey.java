package com.krcon.elif.common.util;

import java.util.Random;

public class TempKey {
	private boolean lowerCheck;
	private int size;

	
	/** 
	 * @param size
	 * @param lowerCheck
	 * @return String
	 */
	public String getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return init();
	}
	
	/** 
	 * @param Number
	 * @return String
	 */
	//문자보내기 6자리
	public String tempKeyGenarator(String Number){
		String lastNumberString = null;
		String numberArray[] = Number.split("-");
		if(numberArray[2].charAt(0) == '0'){
			lastNumberString = "1"+numberArray[2].substring(1, numberArray[2].length());
		}else{
			lastNumberString = numberArray[2];
		}
		String last = Long.toString((Integer.parseInt(lastNumberString) * System.currentTimeMillis()));
		return last.substring(last.length()-6, last.length());
	}
	
	/** 
	 * @param charLength
	 * @return String
	 */
	//자리수만큼 랜덤 숫자를 String으로 return
	public String generateRandomNumber(int charLength) {
		String str = "";
		int d = 0;
		for (int i = 1; i <= charLength; i++){
			Random r = new Random();
			d = r.nextInt(9);
			str = str + Integer.toString(d);
		}
		return str;
    }
	
	/** 
	 * @return String
	 */
	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}
		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}
}
