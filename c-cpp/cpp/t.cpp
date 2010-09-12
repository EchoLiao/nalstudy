/*
 * =====================================================================================
 *
 *       Filename:  t.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  2010年03月23日 23时10分52秒
 *       Revision:  none
 *       Compiler:  cl.exe
 *
 *         Author:  nuoerll (nuoliu), lcy3636@126.com
 *        Company:  mhtt
 *
 *      CopyRight:  Reserve
 *
 * =====================================================================================
 */

#include <iostream>
using namespace std;

double M = 200;

double total(double N)
{
	double score = 43;
	double t = (N-M)/(M*100);
	if (t>=-3 && t<=-1)
		return score;
	else if (t > -1)
		return score - (t - (-1));
	else
		return score - 0.5 * (-3 - t);
}

double frare(double N)
{
	double score = 7;
	double t = (N-M)/(M*100);
	if (t>=-3 && t<=-1)
		return score;
	else if (t > -1)
		return score - (t - (-1));
	else
		return score - 0.5 * (-3 - t);
}



int main()
{
	double N;
	double M1, M2, M3;
	cout<<"请输入M1: ";
	cin>>M1;
	cout<<"请输入M2: ";
	cin>>M2;
	cout<<"请输入M3: ";
	cin>>M3;
	M = (M1 + M2 + M3) / 3;
	cout<<"M1总报价得分: "<<total(M1)<<endl;
	cout<<"M1措施项目费: "<<frare(M1)<<endl;
	cout<<"M2总报价得分: "<<total(M2)<<endl;
	cout<<"M2措施项目费: "<<frare(M2)<<endl;
	cout<<"M3总报价得分: "<<total(M3)<<endl;
	cout<<"M3措施项目费: "<<frare(M3)<<endl;

	return 0;
}
