class ram_sb;

  ram_trans t1, t2;

  mailbox #(ram_trans) mbx1;
  mailbox #(ram_trans) mbx2;

  function new(
    mailbox #(ram_trans) mbx1,
    mailbox #(ram_trans) mbx2
  );
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
  endfunction

  task run();
    forever begin

      fork
        mbx1.get(t1); // from monitor
        mbx2.get(t2); // from reference model
      join

      if (t1.read_addr != t2.read_addr)
        $display("Address mismatch");
      else if (t1.read_data != t2.read_data)
        $display("Data mismatch");
      else
        $display("Data matched successfully");

    end
  endtask

endclass