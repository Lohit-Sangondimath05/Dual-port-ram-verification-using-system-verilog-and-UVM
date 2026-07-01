class ram_wdrv;
  
  ram_trans t1;
  mailbox #(ram_trans) mbx1;
  virtual ram_if.write_drv vif;   // syntax:- virtual interface_name.modport name instance name;
  
  //mapping
  function new(mailbox #(ram_trans) mbx1, virtual ram_if.write_drv vif);
    this.mbx1= mbx1;
    this.vif = vif;
    endfunction
  //Functionality
  task run();
    forever begin
      mbx1.get(t1);
      
      vif.w_drv_cb.write_en <= 1'b1;
      
      repeat(2)
        begin
          
          @(vif.w_drv_cb)
        
          vif.w_drv_cb.write_addr <= t1.write_addr;
      	  vif.w_drv_cb.write_data <= t1.write_data;
        end
      repeat(2)
        begin
           @(vif.w_drv_cb)
          
          vif.w_drv_cb.write_en <= 1'b0;
        end
    end
  endtask
endclass