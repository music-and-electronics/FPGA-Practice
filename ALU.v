module ALU(
    input wire clk,
    input wire ALU_control1,
    input wire ALU_control2,
    input wire Data1_1,
    input wire Data1_2,
    input wire Data2_1,
    input wire Data2_2,
    output wire LED1,
    output wire LED2
);

reg Result[1:0];
reg Data_Register1[1:0];
reg Data_Register2[1:0];
reg Control_Register[1:0];

always@ (posedge clk)
begin
	Data_Register1[0]<=Data1_1;
    Data_Register1[1]<=Data1_2;
    Data_Register2[0]<=Data2_1;
    Data_Register2[1]<=Data2_2;

    Control_Register[0]<=ALU_control1;
    Control_Register[1]<=ALU_control2;

    case({Control_Register[1],Control_Register[0]})
        2'b11 : //Simple Adder 
        begin
            Result[0]<=Data_Register1[0]^Data_Register1[1];
            Result[1]<=Data_Register2[0]^Data_Register2[1]
                       ^(Data_Register1[0]&Data_Register1[1]);
        end
        2'b10 : // Simple And
        begin 
            Result[0]<=Data_Register1[0]&Data_Register2[0];
            Result[1]<=Data_Register1[1]&Data_Register2[1];
        end
        2'b01 : //Simple OR
        begin
            Result[0]<=Data_Register1[0]|Data_Register2[0];
            Result[1]<=Data_Register1[1]|Data_Register2[1];
        end
        2'b00: //Shut up and just turn on light
        begin
            Result[0]<=1'b1;
            Result[1]<=1'b1;
        end
	endcase
end

assign LED1=Result[0];
assign LED2=Result[1];

endmodule