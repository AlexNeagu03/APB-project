////////////////////////////////////////////////////////////////////////////////
// (C) Copyright 2019 <Infineon Technologies Romania> All Rights Reserved
//
// MODULE:
// COMPLIANCE:
// AUTHOR:
// DATE:
// UPDATE:
// ABSTRACT:
// COMMENTS:
////////////////////////////////////////////////////////////////////////////////

 
task check_data_o();
// HINT -- add here checker for data_o  
forever @(dig_vif.data_o or expected_data_o) 
begin
`WAIT_NS(1)
	if(expected_valid_o)
	begin
	assert(dig_vif.data_o === expected_data_o) 
		else  begin 
			`uvm_error("checker",$sformatf("data_o %0h != expected_data_o %0h",dig_vif.data_o, expected_data_o));
		      end
	end	
end
endtask

task check_valid_o();
// HINT -- add here checker for valid_o
forever @(expected_valid_o or dig_vif.valid_o) 
begin
`WAIT_NS(1)
	assert (dig_vif.valid_o === expected_valid_o) 
		else begin 
        		`uvm_error("checker",$sformatf("valid_o %0h != %0h expected_valid_o %0h",dig_vif.valid_o, expected_valid_o));
		end
end 
endtask
