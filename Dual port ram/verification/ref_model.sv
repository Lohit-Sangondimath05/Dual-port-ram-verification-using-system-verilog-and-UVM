class ref_model;

  ram_trans t1, t2;
  mailbox #(ram_trans) mbx1, mbx2, mbx3;

  int mem[int];

  function new(
    mailbox #(ram_trans) mbx1,
    mailbox #(ram_trans) mbx2,
    mailbox #(ram_trans) mbx3
  );
    this.mbx1 = mbx1;
    this.mbx2 = mbx2;
    this.mbx3 = mbx3;
  endfunction

  task run();
    forever begin

      fork
        begin
          mbx1.get(t1); // from write monitor
          mem[t1.write_addr] = t1.write_addr;
        end

        begin
          mbx2.get(t2); // from read monitor

          if (mem.exists(t2.read_addr))
            t2.read_data = mem[t2.read_addr];
          else
            $display("Ref model: Data doesn't exist in this read addr");

          mbx3.put(t2); // to scoreboard
        end
      join

    end
  endtask

endclass