
configuration lcd_controller_tb_conf of lcd_controller_tb is
   for bench
    --  for all : lcd_controller
         --use entity work.lcd_controller(rtl);
    --  end for; -- all : dprod
   end for; -- bench
end configuration lcd_controller_tb_conf;
