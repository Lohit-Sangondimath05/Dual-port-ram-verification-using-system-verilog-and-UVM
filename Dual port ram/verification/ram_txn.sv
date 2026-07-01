class ram_trans;

  rand bit write_en;
  rand bit read_en;

  rand bit [31:0] write_addr;
  rand bit [31:0] write_data;

  rand bit [31:0]read_addr;

  bit [31:0] read_data;

  constraint c1 {
  write_en || read_en;
}
  constraint c2 {
  write_en dist {1:=50,0:=50};
  read_en  dist {1:=50,0:=50};
}
  constraint c3 {
  write_addr inside {[0:255]};
  read_addr  inside {[0:255]};
}
endclass
