create index xs_xm_idx 
    on xs(xm)
    tablespace "MYTS"
    initrans 2 /* ��ʼ������������еĸ��� */
    maxtrans 255 /* �����е����������ĸ��� */ 
    nosort;
    /* �б����ǰ���������� */ 
