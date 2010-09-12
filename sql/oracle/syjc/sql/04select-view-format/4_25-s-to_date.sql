select xm, zym 
    from (select *
	from xs 
	where cssj < to_date('19860101', 'YYYYMMDD')
    );
    
select xm, zym 
    from xs 
    where cssj < to_date('19860101', 'YYYYMMDD');
