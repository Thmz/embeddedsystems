configuration rtc_tb_conf of rtc_tb is
   for bench
      for all : rtc
         use entity work.rtc;
      end for; -- all : dprod
   end for; -- bench
end configuration rtc_tb_conf;
