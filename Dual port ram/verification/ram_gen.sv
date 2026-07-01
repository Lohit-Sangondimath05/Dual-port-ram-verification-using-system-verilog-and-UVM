class ram_gen;
  
  //declarations
  ram_trans txn,t1,t2;
  mailbox #(ram_trans) mbx1, mbx2;
  
  
  //mapping
  function new(mailbox #(ram_trans) mbx1, mbx2);
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction
  
  //Functionality
  task run();
    
    txn=new();
    
    repeat(5)
      begin
        txn.randomize();
      
        t1 = new();
        t2 = new();
    
        mbx1.put(t1);//sent to wdrive
        mbx2.put(t2);// sent to rdrive
      end
  endtask
 
endclass