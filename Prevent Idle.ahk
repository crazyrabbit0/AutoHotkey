
;############################## Functions ##############################

	prevent_idle(idle_time := 6 * 60 * 1000, days := '1-7', hours := '0-23')
  {
      timer_time := idle_time // 3        ; // not / — a float period can throw TypeError
      d := StrSplit(days, '-')
      if !d.Has(2)
          d.Push(7)
      h := StrSplit(hours, '-')
      if !h.Has(2)
          h.Push(23)
      d1 := Integer(d[1]), d2 := Integer(d[2])
      h1 := Integer(h[1]), h2 := Integer(h[2])
      timer_loop()
      {
          wd := A_WDay, hr := Integer(A_Hour)      ; re-read every tick
          ; wrap-aware: '6-2' = Fri..Mon, '22-6' = 22:00..06:59
          ok_day  := (d1 <= d2) ? (wd >= d1 && wd <= d2) : (wd >= d1 || wd <= d2)
          ok_hour := (h1 <= h2) ? (hr >= h1 && hr <= h2) : (hr >= h1 || hr <= h2)
          if ok_day && ok_hour && A_TimeIdle > idle_time
              Send '{Blind}{vkE8}'
      }
      SetTimer(timer_loop, timer_time)
      return timer_loop    ; SetTimer(f, 0) to stop, SetTimer(f, timer_time) to resume
  }
