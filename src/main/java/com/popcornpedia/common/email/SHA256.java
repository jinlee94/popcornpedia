package com.popcornpedia.common.email;

import java.security.MessageDigest;

public class SHA256 {
	// 이메일을 해쉬 값으로 변환하는 메서드
	public static String getSHA256(String email) 
	{
		StringBuffer result = new StringBuffer();
		try
		{
			/* MessageDiget객체 확보 해쉬방식은 SHA-256방식
			 MD2, DM4, MD5, SHA-1, SHA-256, SHA-512 방식이 있음 */
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			// 보안을 위해서 digest 생성
			byte[] salt = "Encrytion Salt.".getBytes();
			
			digest.reset();
			// update를 통하여 다이제스트를 갱신
			digest.update(salt);
			
			byte[] chars = digest.digest(email.getBytes("UTF-8"));
			for(int i =0; i < chars.length; i++)
			{
				String hex = Integer.toHexString(0xFF & chars[i]);
				if(hex.length() == 1) {
					result.append("0");
				}
				result.append(hex);
			}
		}
		catch(Exception e) {e.printStackTrace();}
		return result.toString();
	}
}
