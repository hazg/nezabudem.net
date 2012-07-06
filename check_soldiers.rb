Soldier.transaction do Soldier.all.each{|s| s.delete if s.fio == "\r"} end
