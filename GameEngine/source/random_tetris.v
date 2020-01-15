`timescale 1ns / 1ps
module random_tetris(clk, rst, signal_for_next, out);
	input clk, rst;
	input signal_for_next;
	output reg [2:0] out;
	//�C���|�����C�ؤ��P������A�è̷��H�������Ǳ����A�@��������|�A�}�l�s���@��
	reg [2:0] nextout;
	reg [2:0] cnt, nextcnt;//�ƨ�now�����ĴX��
	reg [2:0] isseven, nextisseven;//��e���ǥΨ�ĴX�Ӥ��
	reg [9:0] howmanyclk, nexthowmanyclk;//�g�L�X��clk
	reg [2:0] now [6:0];//��e�������
	reg [2:0] nextnow [6:0];
	reg [2:0] arr [6:0];//�@����s��������ǡA��e�o������Χ��A�ǵ�now
	reg [2:0] nextarr [6:0];
	reg [2:0] label, nextlabel;//�M�warr��s�覡
	always@(posedge clk)begin
		if(rst)begin
			out <= 3'b001;
			cnt <= 3'd0;
			isseven <= 3'd0;
			howmanyclk <= 10'd0;
			{now[6], now[5], now[4], now[3], now[2], now[1], now[0]} <= 21'b111_110_101_100_011_010_001;
			{arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]} <= 21'b111_110_101_100_011_010_001;
			label <= 3'b000;
		end
		else begin
			out <= nextout;
			cnt <= nextcnt;
			isseven <= nextisseven;
			howmanyclk <= nexthowmanyclk;
			{now[6], now[5], now[4], now[3], now[2], now[1], now[0]} <= {nextnow[6], nextnow[5], nextnow[4], nextnow[3], nextnow[2], nextnow[1], nextnow[0]};
			{arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]} <= {nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]};
			label <= nextlabel;
		end
	end
	always@(*)begin
		if((signal_for_next == 1'b1))begin
			nextout = now[cnt];
			if(isseven < 3'd6)begin//��e�o��������٨S�Χ�
			    nextisseven = isseven + 3'd1; 
			    {nextnow[6], nextnow[5], nextnow[4], nextnow[3], nextnow[2], nextnow[1], nextnow[0]} = {now[6], now[5], now[4], now[3], now[2], now[1], now[0]};
			    if(cnt < 3'd6)begin
                    nextcnt = cnt + 3'd1;
                end
                else begin
                    nextcnt = 3'd0;
                end
			end
			else begin//�Χ��F�A��s�������
			    nextisseven = 3'd0;
			    nextcnt = howmanyclk % 7;
			    {nextnow[6], nextnow[5], nextnow[4], nextnow[3], nextnow[2], nextnow[1], nextnow[0]} = {arr[6], arr[5], arr[4], arr[3], arr[2], arr[1], arr[0]};
			end
		end
		else begin
			nextout = out;
			nextcnt = cnt;
			nextisseven = isseven;
			{nextnow[6], nextnow[5], nextnow[4], nextnow[3], nextnow[2], nextnow[1], nextnow[0]} = {now[6], now[5], now[4], now[3], now[2], now[1], now[0]};
		end
	end
	always@(*)begin
	    nexthowmanyclk = howmanyclk + 10'd1;
		if(label < 3'd6)begin
			nextlabel = label + 3'd1;
		end
		else begin
			nextlabel = 3'd0;
		end
	end
	always@(*)begin
		case(label)//���_��s�������
			3'd0:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[6], arr[5], arr[0], arr[3], arr[2], arr[1], arr[4]};
			end
			3'd1:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[6], arr[1], arr[4], arr[3], arr[2], arr[5], arr[0]};
			end
			3'd2:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[2], arr[5], arr[4], arr[3], arr[6], arr[1], arr[0]};
			end
			3'd3:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[6], arr[5], arr[4], arr[0], arr[2], arr[1], arr[3]};
			end
			3'd4:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[6], arr[5], arr[1], arr[3], arr[2], arr[4], arr[0]};
			end
			3'd5:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[6], arr[2], arr[4], arr[3], arr[5], arr[1], arr[0]};
			end
			3'd6:begin
				{nextarr[6], nextarr[5], nextarr[4], nextarr[3], nextarr[2], nextarr[1], nextarr[0]} = {arr[3], arr[5], arr[4], arr[6], arr[2], arr[1], arr[0]};
			end
		endcase
	end
endmodule


