#!/bin/bash
#例子 10-23. 在实际的任务中使用"continue N"

# Albert Reiner 给出了一个关于使用"continue N"的例子:
# ---------------------------------------------------------

#  假定我有很多任务需要运行,
#+ 这些任务要处理一些数据，这些数据保存在一个目录下的文件里，文件是以预先给定的模式命名的
#+ 有几个机器会存取这个目录
#+ 我想把工作都分配给这几个不同的机器.
#+ 然后我一般会在每个机器里运行类似下面的代码:

while true
do
  for n in .iso.*
  do
    [ "$n" = ".iso.opts" ] && continue
    beta=${n#.iso.}
    [ -r .Iso.$beta ] && continue
    [ -r .lock.$beta ] && sleep 10 && continue
    lockfile -r0 .lock.$beta || continue
    echo -n "$beta: " `date`
    run-isotherm $beta
    date
    ls -alF .Iso.$beta
    [ -r .Iso.$beta ] && rm -f .lock.$beta
    continue 2
  done
  break
done

#  在我的应用里的细节（尤其是sleep N）更一般的模式是：
#

while true
do
  for job in {pattern}
  do
    {job already done or running} && continue
    {mark job as running, do job, mark job as done}
    continue 2
  done
  break        # 而所谓的 `sleep 600' 只是想避免程序太快结束达不到演示的效果.
done

#  脚本只有当所有任务都完成之后才会停止运行
#+ (包括那些运行时新添加的任务).
#+ 
#+ 通过使用合适的lockfiles可以使几个机器协作运作而不会产生重复的处理
#+ [在我的情况里，重复的处理会使处理时间延长多一倍时间，因此我很想避免这个问题].
#+ 同样，如果每次都从头开始搜索，可以由文件名得到处理顺序
#+ 当然,还有一种办法也可以不使用`continue 2',
#+ 但这样就不得不检查相同的任务是不是已经完成过了
#+  (而我们应该立马来找到下一个要运行的任务)
#+ (在演示的情况里，检查新任务前我们终止或睡眠了一段长时间).
#
