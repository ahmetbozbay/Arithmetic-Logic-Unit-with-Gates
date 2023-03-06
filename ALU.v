module alu(A,B,C,D,E,out,outadder,outsub,outand,outor,outdec,outinc,outmov,outsh_l,outsh_r);

	input [7:0] A,B;
	input [3:0] C;
	input [1:0] D;
	input E;

	output [7:0] out;
	output outadder,outsub,outand,outor,outdec,outinc,outmov,outsh_l,outsh_r;


	wire [7:0] a_2s,dec_cable;
	wire [7:0] AplusB,AminB;
	wire [7:0] AandB,AorB;
	wire [7:0] AmultiB;
	wire [7:0] inc_cable;
	wire [7:0] kablo1,kablo2,kablo3,kablo4,kablo5,kablo6,kablo7,kablo8;

	wire t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26;

	adder8bit adder(A,B,1'b0,AplusB,t1,t2,t3,t4);  

	submain substractor(A,B,1'b0,AminB,t5,t6,t7,t8);

	bitWise_and bwand(A,B,AandB,t9,t10);    

	bitWise_or bwor(A,B,AorB,t11,t12);  
	
	decrement dec1(B,dec_cable,t13,t14,t15,t16);
	
	increment inc1(B,inc_cable,t17,t18,t19,t20);
	
	mov mov1(A,AmultiB,t21,t22);
	
	shiftleft sh_l(A,kablo1,t23,t24);
	
	shiftright rg_l(A,kablo2,t25,t26);
	

	MUX8to1 mux1(a_2s[0],dec_cable[0],AplusB[0],AminB[0],AandB[0],AorB[0],AmultiB[0],inc_cable[0],kablo1[0],kablo2[0],kablo7[0],kablo8[0],kablo3[0],kablo4[0],kablo5[0],kablo6[0],C,out[0]);
	MUX8to1 mux2(a_2s[1],dec_cable[1],AplusB[1],AminB[1],AandB[1],AorB[1],AmultiB[1],inc_cable[1],kablo1[1],kablo2[1],kablo7[1],kablo8[1],kablo3[1],kablo4[1],kablo5[1],kablo6[1],C,out[1]);
	MUX8to1 mux3(a_2s[2],dec_cable[2],AplusB[2],AminB[2],AandB[2],AorB[2],AmultiB[2],inc_cable[2],kablo1[2],kablo2[2],kablo7[2],kablo8[2],kablo3[2],kablo4[2],kablo5[2],kablo6[2],C,out[2]);
	MUX8to1 mux4(a_2s[3],dec_cable[3],AplusB[3],AminB[3],AandB[3],AorB[3],AmultiB[3],inc_cable[3],kablo1[3],kablo2[3],kablo7[3],kablo8[3],kablo3[3],kablo4[3],kablo5[3],kablo6[3],C,out[3]);
	MUX8to1 mux5(a_2s[4],dec_cable[4],AplusB[4],AminB[4],AandB[4],AorB[4],AmultiB[4],inc_cable[4],kablo1[4],kablo2[4],kablo7[4],kablo8[4],kablo3[4],kablo4[4],kablo5[4],kablo6[4],C,out[4]);
	MUX8to1 mux6(a_2s[5],dec_cable[5],AplusB[5],AminB[5],AandB[5],AorB[5],AmultiB[5],inc_cable[5],kablo1[5],kablo2[5],kablo7[5],kablo8[5],kablo3[5],kablo4[5],kablo5[5],kablo6[5],C,out[5]);
	MUX8to1 mux7(a_2s[6],dec_cable[6],AplusB[6],AminB[6],AandB[6],AorB[6],AmultiB[6],inc_cable[6],kablo1[6],kablo2[6],kablo7[6],kablo8[6],kablo3[6],kablo4[6],kablo5[6],kablo6[6],C,out[6]);
	MUX8to1 mux8(a_2s[7],dec_cable[7],AplusB[7],AminB[7],AandB[7],AorB[7],AmultiB[7],inc_cable[7],kablo1[7],kablo2[7],kablo7[7],kablo8[7],kablo3[7],kablo4[7],kablo5[7],kablo6[7],C,out[7]);
	
	flagmux4bit adder8bit1(t1,t2,t3,t4,D,outadder);
	flagmux4bit submain1(t5,t6,t7,t8,D,outsub);
	flagmux4bit decrement(t13,t14,t15,t16,D,outdec);
	flagmux4bit increment(t17,t18,t19,t20,D,outinc);
	flagmux2bit bitwiseand(t9,t10,E,outand);
	flagmux2bit bitwiseor(t11,t12,E,outor);
	flagmux2bit mov(t21,t22,E,outmov);
	flagmux2bit shiftleft(t23,t24,E,outsh_l);
	flagmux2bit shiftright(t25,t26,E,outsh_r);
endmodule

module shiftright(a,out,negativeflag,zeroflag,b);

	input [7:0]a,b;
	
	output [7:0] out;
	
	output negativeflag,zeroflag;
	
	nor n1(zeroflag,out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]);
	or o1(negativeflag,out[7]);
	
	and(out[7],a[7],1'b0);
	or(out[6],a[7],a[7]);
	or(out[5],a[6],a[6]);
	or(out[4],a[5],a[5]);
	or(out[3],a[4],a[4]);
	or(out[2],a[3],a[3]);
	or(out[1],a[2],a[2]);
	or(out[0],a[1],a[1]);
	
endmodule


module shiftleft(a,out,negativeflag,zeroflag,b);

	input [7:0]a,b;
	
	output [7:0] out;
	
	output negativeflag,zeroflag;
	
	and(out[0],a[0],1'b0);
	or(out[1],a[0],a[0]);
	or(out[2],a[1],a[1]);
	or(out[3],a[2],a[2]);
	or(out[4],a[3],a[3]);
	or(out[5],a[4],a[4]);
	or(out[6],a[5],a[5]);
	or(out[7],a[6],a[6]);
	nor n1(zeroflag,out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]);
	or o1(negativeflag,out[7]);
	
	
endmodule

module mov(a,o,negativeflag,zeroflag);

	input [7:0]a;
	
	output [7:0]o;
	
	wire t1,t2,t3,t4,t5,t6,t7,t8;
	
	output negativeflag,zeroflag;
	
	or suvi1(o[0],a[0],t1);
	or suvi2(o[1],a[1],t2);
	or suvi3(o[2],a[2],t3);
	or suvi4(o[3],a[3],t4);
	or suvi5(o[4],a[4],t5);
	or suvi6(o[5],a[5],t6);
	or suvi7(o[6],a[6],t7);
	or suvi8(o[7],a[7],t8);
	nor n1(zeroflag,o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7]);
	or o1(negativeflag,o[7]);
	
endmodule

module submain(a,b,cin,o,zeroflag,negativeflag,carryoutflag,overflowflag,carryout);

	input  [7:0] a, b; input cin;
	output [7:0] o; output carryout,zeroflag,negativeflag,carryoutflag,overflowflag;
	
	wire t1,t2,t3,t4,t5,t6,t7,t8;
	subs(a[0],b[0],t1,o[0],t2);
	subs(a[1],b[1],t2,o[1],t3);
	subs(a[2],b[2],t3,o[2],t4);
	subs(a[3],b[3],t4,o[3],t5);
	subs(a[4],b[4],t5,o[4],t6);
	subs(a[5],b[5],t6,o[5],t7);
	subs(a[6],b[6],t7,o[6],t8);
	subs(a[7],b[7],cin,o[7],carryout);
	nor n1(zeroflag,o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7]);
	or o1(negativeflag,o[7]);
	or o2(carryoutflag,carryout);
	xor x1(overflowflag,carryout,cout7);
	
endmodule


module subs(a,b,b_in,o,borrow);

	input a, b,b_in;
	output o,borrow;
	
	wire t1, t2, t3;
	
	xor (t1,a,b);
	xor (o,t1,b_in);
	and (t2,~a,b);
	and (t3,~t1,b_in);
	or (borrow,t3,t2);
	
endmodule



module adder8bit(a,b,cin,s,zeroflag,negativeflag,carryoutflag,overflowflag,cout);

	input  [7:0] a, b; input cin;
	output [7:0] s; output cout,zeroflag,negativeflag,carryoutflag,overflowflag;

	wire cout1, cout2, cout3, cout4, cout5, cout6, cout7;



	FullAdder fa0(a[0],b[0],cin,s[0],cout1);
	FullAdder fa1(a[1],b[1],cout1,s[1],cout2);
	FullAdder fa2(a[2],b[2],cout2,s[2],cout3);
	FullAdder fa3(a[3],b[3],cout3,s[3],cout4);
	FullAdder fa4(a[4],b[4],cout4,s[4],cout5);
	FullAdder fa5(a[5],b[5],cout5,s[5],cout6);
	FullAdder fa6(a[6],b[6],cout6,s[6],cout7);
	FullAdder fa7(a[7],b[7],cout7,s[7],cout);
	nor n1(zeroflag,s[0],s[1],s[2],s[3],s[4],s[5],s[6],s[7]);
	or o1(negativeflag,s[7]);
	or o2(carryoutflag,cout);
	xor x1(overflowflag,cout,cout7);
endmodule


module FullAdder(a,b,cin,s,cout);
	
	input a,b,cin; 
	output s,cout;
	
	wire t1,t2,t3,t4;
	
	xor x1(t1,a,b);
	xor x2(s,t1,cin);
	and a1(t2,cin,t1);
	and a2(t3,a,b);
	or  o1(cout,t2,t3);

endmodule


module bitWise_and(a,b,out,zeroflag,negativeflag);			

	input [7:0] a,b;
	output [7:0] out;
	output negativeflag,zeroflag;

	and(out[0],a[0],b[0]);
	and(out[1],a[1],b[1]);
	and(out[2],a[2],b[2]);
	and(out[3],a[3],b[3]);
	and(out[4],a[4],b[4]);
	and(out[5],a[5],b[5]);
	and(out[6],a[6],b[6]);
	and(out[7],a[7],b[7]);
	nor n1(zeroflag,out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]);
	or o1(negativeflag,out[7]);
endmodule

module bitWise_or(a,b,out,zeroflag,negativeflag);			

	input [7:0] a,b;
	output [7:0] out;
	output negativeflag,zeroflag;
	or(out[0],a[0],b[0]);
	or(out[1],a[1],b[1]);
	or(out[2],a[2],b[2]);
	or(out[3],a[3],b[3]);
	or(out[4],a[4],b[4]);
	or(out[5],a[5],b[5]);
	or(out[6],a[6],b[6]);
	or(out[7],a[7],b[7]);
	nor n1(zeroflag,out[0],out[1],out[2],out[3],out[4],out[5],out[6],out[7]);
	or o1(negativeflag,out[7]);

endmodule


module decrement(b,o,zeroflag,negativeflag,carryoutflag,overflowflag,carryout,a);

	input [7:0] b,a;
	output [7:0] o;
	output carryout,zeroflag,negativeflag,carryoutflag,overflowflag;
	wire t1,t2,t3,t4,t5,t6,t7,t8;
	subs(b[0],8'b00000001,t1,o[0],t2);
	subs(b[1],8'b00000000,t2,o[1],t3);
	subs(b[2],8'b00000000,t3,o[2],t4);
	subs(b[3],8'b00000000,t4,o[3],t5);
	subs(b[4],8'b00000000,t5,o[4],t6);
	subs(b[5],8'b00000000,t6,o[5],t7);
	subs(b[6],8'b00000000,t7,o[6],t8);
	subs(b[7],8'b00000000,1'b0,o[7],carryout);
	nor n1(zeroflag,o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7]);
	or o1(negativeflag,o[7]);
	or o2(carryoutflag,carryout);
	xor x1(overflowflag,carryout,cout7);
	
	
endmodule


module increment(b,o,zeroflag,negativeflag,carryoutflag,overflowflag,carryout,a);

	input [7:0] b,a;
	output [7:0] o;
	output carryout,zeroflag,negativeflag,carryoutflag,overflowflag;
	wire t1,t2,t3,t4,t5,t6,t7;
	FullAdder(8'b00000001,b[0],1'b0,o[0],t1);
	FullAdder(8'b00000000,b[1],t1,o[1],t2);
	FullAdder(8'b00000000,b[2],t2,o[2],t3);
	FullAdder(8'b00000000,b[3],t3,o[3],t4);
	FullAdder(8'b00000000,b[4],t4,o[4],t5);
	FullAdder(8'b00000000,b[5],t5,o[5],t6);
	FullAdder(8'b00000000,b[6],t6,o[6],t7);
	FullAdder(8'b00000000,b[7],t7,o[7],carryout);
	nor n1(zeroflag,o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7]);
	or o1(negativeflag,o[7]);
	or o2(carryoutflag,carryout);
	xor x1(overflowflag,carryout,cout7);

endmodule


module MUX8to1(i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,c,out);		

	input i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16;
	input [3:0] c;
	output out;
	wire [3:0] nc;
	wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16;

	not(nc[0],c[0]);
	not(nc[1],c[1]);
	not(nc[2],c[2]);
	not(nc[3],c[3]);

	and(w1,i1,nc[3],nc[2],nc[1],nc[0]);
	and(w2,i2,nc[3],nc[2],nc[1],c[0]);
	and(w3,i3,nc[3],nc[2],c[1],nc[0]);
	and(w4,i4,nc[3],nc[2],c[1],c[0]);
	and(w5,i5,nc[3],c[2],nc[1],nc[0]);
	and(w6,i6,nc[3],c[2],nc[1],c[0]);
	and(w7,i7,nc[3],c[2],c[1],nc[0]);
	and(w8,i8,nc[3],c[2],c[1],c[0]);
	and(w9,i9,c[3],nc[2],nc[1],nc[0]);
	and(w10,i10,c[3],nc[2],nc[1],c[0]);
	and(w11,i11,c[3],nc[2],c[1],nc[0]);
	and(w12,i12,c[3],nc[2],c[1],c[0]);
	and(w13,i13,c[3],c[2],nc[1],nc[0]);
	and(w14,i14,c[3],c[2],nc[1],c[0]);
	and(w15,i15,c[3],c[2],c[1],nc[0]);
	and(w16,i16,c[3],c[2],c[1],c[0]);

	or(out,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16);

endmodule

module flagmux4bit(i1,i2,i3,i4,c,out,out2,out3,out4);
	input i1,i2,i3,i4;
	input [1:0] c;
	output out,out2,out3,out4;
	wire [1:0] nc;
	wire w1,w2,w3,w4;
	not(nc[0],c[0]);
	not(nc[1],c[1]);
	and(w1,i1,nc[1],nc[0]);
	and(w2,i2,nc[1],c[0]);
	and(w3,i3,c[1],nc[0]);
	and(w4,i4,c[1],c[0]);
	
	or(out,w1,w2,w3,w4);

	
endmodule


module flagmux2bit(i1,i2,c,out,out2);

	input i1,i2;
	input c;
	output out,out2;
	wire nc;
	wire w1,w2;
	not(nc,c);
	and(w1,i1,nc);
	and(w2,i2,c);
	or(out,w1,w2);

endmodule