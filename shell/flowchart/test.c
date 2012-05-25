/*
 * ===========================================================================
 *
 *       Filename:  test.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2012年05月25日 19时49分52秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  nuoerlz (nuoliu), nuoerlz@gmail.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * ===========================================================================
 */

{ ///GSM_Do_FB>
	R.S_FB.Head=SmsFB; ///设置缺省值
	/// 复制结构到内存
	/// 阀门关闭?马达状态2号:马达状态1号
	///获取验证数据
/// Gsm_Wait_S>
    leng=get_strlen(ack); ///取得ack长度
    while(timeout--)   //等待接收完毕///超时检查?:>返回超时
       if(U6RecCount>oldint)oldint=U6RecCount; ///计数大于保留?保留等于计数
       delay_1ms(6); ///延时6毫秒
       if(U6RecCount==oldint) ///xxxx保留?:>返回超时
          a=find_arr(GSM_RT,U6RecCount,ack,leng); ///接收信息
          if(a==SUCCESS){return SUCCESS;} ///接收Ack成功?>返回成功
          ///接收错误信息
          if(a==SUCCESS)return ACK_ERROR;///接收Err成功?>返回错误
    } ///测试
    return ACK_TIMEOUT;///>返回超时
{///Gsm_Send_AT>
	i=get_strlen(Send_AT); ///获取发送长度
	UART6_SendData(Send_AT,i); ///发送数据
	if(Flag_Order) ///order标志?:>等待返回
		tmp[0]=Flag_Order/10+0x30;tmp[1]=Flag_Order%10+0x30;///根据order格式化数据
		UART6_SendData(tmp,4);///发送格式化数据
	i=Gsm_Wait_S(Find_AT,Gsm_de_search_cnt);///>等待返回
	Telephone_NO = GSM_RT+DoubleChar[3]-6 ;////
		if(f>1)FlagBit.F_GsmAllRead=1;////
	Gsm_Order=0;FlagBit.F_GsmReadEn=0;FlagBit.F_GsmAllRead=0;////
		Gsm_AgainStart();////

