/* ���Ҳ�ͬ�γ̳ɼ���ͬ��ѧ����ѧ��, �γ̺źͳɼ� */
select a.xh, a.kch, b.kch, a.cj
    from xs_kc a join xs_kc b 
	on a.cj = b.cj and a.xh = b.xh 
	    and a.kch != b.kch;
