-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua
function vowelType(v)
	s={aa=1,ii=2}
	return s[v]~=nil
end
x=96
y=24
s='j_eo--n_eun_  ggaa--bbii'
t={{}}
i=1
while i<#s do
	substring=string.sub(s,i,i+1)
	if substring=='--' then 
	table.insert(t,{})end
	if substring~='--' and
		substring~='  '
	 then
	table.insert(t[#t],substring)
	end
	if substring=='  ' then
	table.insert(t,{1}) 
	table.insert(t,{})
	end
	i=i+2
end
for i=0,#t do
	if t[i]~=nil then
	if t[i][1]~=1 then
		vowel=t[i][2]
		if vowelType(vowel) then--=='aa' then
			table.insert(t[i],2)
		end
	end
end
end
function TIC()

	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btn(2) then x=x-1 end
	if btn(3) then x=x+1 end

	cls(13)
	print("HELLO WORLD!",84,84)
	for i=1,#t do
		print(t[i],100,i*16)
		for j=1,#t[i] do
			print(t[i][j],j*16,i*16)
		end
	end
end

tiles   = 1<<0 -- 1
sprites = 1<<1 -- 2
map_     = 1<<2 -- 4
sfx_     = 1<<3 -- 8
music_   = 1<<4 -- 16
palette = 1<<5 -- 32
flags   = 1<<6 -- 64
screen  = 1<<7 -- 128 (as of 0.90)
bank = 0
--sync(tiles,bank)
--sync(sprites,bank)
--sync(tiles,bank)
--sync(palette,0)
--sync(map_,1)
hangul={
	z_=352,
	consonants={g_=256,kk=257,n_=258,d_=259,dd=260,r_=261,m_=262,b_=272,bb=273,s_=274,ss=275,
	ng=276,j_=277,jj=278,ch=288,k_=289,t_=290,p_=291,h_=292,z_=352,O_=276,l_=261
	},
	vowels={	
		z=352,a_=293,ae=294,ya=304,yE=305,eo=306,e_=307,yO=308,ye=309,o_=310,wa=320,wE=321,
		wi=322,yo=323,u_=324,wo=325,we=326,ui=336,yu=337,pt=338,cm=339,eu=340,Ui=341,i_=342
	}
}
maxSpeed=16
t=0
position={
	x=96,
	y=24
}
speed=0
count=0
function button(id,dimension)
	local sign=id%2
	if sign == 0 then sign=-1 end
	if btn(id) then 
		speed=(1+speed)
		sum=(speed*sign)/count
		position[dimension]=position[dimension]+sum
		return id
	end
	return 'none'
end
room={x=0,y=0}
resolution={
	x=240,y=136
}
tilePixels=8
subpixelsPerPixel=16
function input()
	cls(13)
	map(room.x*resolution.x/tilePixels,
		room.y*resolution.y/tilePixels)
	for i=0,3 do
		if btn(i) then  
			count=count+1
		end
	end
	button(0,'y')
	button(1,'y')
	button(2,'x')
	button(3,'x')
	
	if count==0 then	
		speed=0
	end
	pixel={
		x=position.x/subpixelsPerPixel,
		y=position.y/subpixelsPerPixel
	}
	maxSpeed=32
	if speed>maxSpeed then 
		speed=maxSpeed 
	end
	if pixel.x>240 then 
		position.x=0 
		room.x=room.x+1
	end
	if pixel.x<0 then 
		room.x=room.x-1
		position.x=240*16 
	end
	if pixel.y<0 then 
		position.y=136*16 
		room.y=room.y-1
	end
	if pixel.y>136 then 
		position.y=0 
		room.y=room.y+1
	end
	if room.x<0 then room.x=7 end
	if room.y<0 then room.y=7 end
	
	if room.x>7 then room.x=0 end
	
	if room.y>7 then room.y=0 end
	rectb(0,0,resolution.x,resolution.y,5)
	--spr(--math.random(0,subpixelsPerPixel-1)*subpixelsPerPixel,
	rect(pixel.x,pixel.y,16,16,4)--1,1,0,0,1,1)
	t=t+1
	count=0
end
function TIC()
	input()
	matrix()
	stringToTable()
end
function vowelType(s)
	horizontal={a_=293,ae=294,ya=304,yE=305,eo=306,e_=307,
	yO=308,ye=309,i_=342}
	
	vertical={o_=310,eu=340,yo=323,u_=324,yu=337}
	diphthong={wa=320,wE=321,
		wi=322,wo=325,we=326,ui=336,
		pt=338,cm=339,Ui=341}
	type=0
	if horizontal[s]~=nil then type=1 end
	if vertical[s]~=nil then type=2 end
	if diphthong[s]~=nil then type=3 end
	print(s,0,0)
	return type

end
function stringToTable()
	s="g_a_44b_i_"
	tabla={{}}
	j=1
	k=1
	i=1
	stringLength=#s
	while i<stringLength do 
		letter=string.sub(s,i,2)
		print(letter,69,44)
		if letter=='44' then 
		table.insert(tabla,{}) 
		j=j+1
		end
		if letter~='44' then 
		table.insert(tabla[j],letter) end
		i=i+1
	end
--	for i=0,
	print(#s,0,100)
	for i=1,#tabla do for j=1,#tabla[i] do end 
		print(4 .. tabla[i][j],i*	16,j*16)
	end
	print(tabla[1][2] .. i,40,40)
	for i=1,#tabla do
		type=vowelType(tabla[i][2])
		print(tabla[i][2],32,32) 
		table.insert(tabla[i],type)--tengo que insertarlo primero
	end
	
		print(--string.sub(s,1,2)
		#s,100,100)
		return tabla
end
function horizontal(x,y,c1,v1,c2)
	syllable(x,y,c1,v1,nil,nil,c2,8)
end
function matrix(s)
	w=14
	h=20
	tiles={x=17,y=6}
	syllables={
		{1,'j_','eo'},{2,'n_','eu','n_'},
		{1},
		{1,'g_','a_'},{2,'b_','eu'},{1,'r_','i_'},{1,'O_','e_','l_'},
		{1,'ng','i_'},{1,'ng','e_'},
		{2,'ng','yo'}
	}
	syllables=stringToTable()
	print(syllables[1][1],64,64)
	for i=1,#syllables do 
		cluster=syllables[i]
		type=cluster[#cluster]--1]
		x=(i-1)*14
		if type == 1 then
			horizontal(
			x,
			0,cluster[1],cluster[2],cluster[3])
		end
		if type == 2 then
			vertical(x,0,cluster[1],cluster[2],cluster[3])
		end	
	end
end

function vertical(x,y,c1,v2,c2)
	syllable(x,y,c1,nil,v2,nil,c2)
end

function hiatus(x,y,c1,v3,c2)
	syllable(x,y,c1,nil,nil,v3,c2)
end

function syllable(x,y,c1,v1,v2,v3,c2,batchim)
	transparent=12
	if batchim==nil then batchim = 11 end
	consonant={
		hangul.consonants[c1],x,y,transparent
	}
	rightVowel={
		hangul.vowels[v1],x+6,y,transparent
	}
	downVowel={
		hangul.vowels[v2],x,y+5,transparent
	}
	finalConsonant={
		hangul.consonants[c2],x,y+batchim,transparent
	}
	diphthong={
		hangul.vowels[v3],x+4,y+5,12
	}
	sprite(consonant)
	sprite(rightVowel)	
	sprite(downVowel)
	sprite(finalConsonant)
	sprite(diphthong)
end

function sprite(letter)
	spr(table.unpack(letter))
end
-- <TILES>
-- 000:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 001:ddddddddccdddccccccdccccccdddcccdddddddddcccccddcccccccddcccccdd
-- 002:dedededeececededcecedeceededecedcecedeceecececedcecedeceedededed
-- 003:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 004:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 005:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 006:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 007:ddcccddccddccdcccdddccccccddcccdccddccddccddcdddcccdcddccccdcddc
-- 008:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 009:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 010:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 011:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 012:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 013:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 014:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 015:cccccccccdcccccccccccccccccccdcccccccccccccdcccccccccccccccccccd
-- 016:cccccccdcedcceccecececececdedcedceddedecdeddededddedeeddcddeeddc
-- 017:dcdcecdccdcececddeedceeeecdeecceeddeddecceedeecedecdedcecdeeceed
-- 018:eeededeee0dedee0ededeeeeeedeeeee0eeee0e0eeee0e0eeeeee0e0e0eeeeee
-- 019:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 020:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 021:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 022:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 023:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 024:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 025:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 026:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 027:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 028:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 029:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 030:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 031:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 032:dcdcdc00cdc000cdde0d0ddccd0dddcdd0d0e0dcc0ed0de0d00edede0dedede0
-- 033:0cdcdcdcc000cdcddc0e0cdccded0dcdded0e0dce0eee0cdde0e00ece0e0e00d
-- 034:cccccccccdcccccdccccdcccccccccccdccccccccccccccdcccccccccdcccccc
-- 035:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 036:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 037:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 038:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 039:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 040:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 041:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 042:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 043:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 044:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 045:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 046:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 047:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 048:00eeee0e0e00eeeee00e0e0ec0e0e000dc000e00cde0000edcdee0edcdcdee00
-- 049:0e0e0e0ce0e0ee0d0e0e00dce000e0cd00000edce000edcdde0eecec00eecdcd
-- 050:ccccccedccccceceeecceddeececededecdeeeeccecdeedcddedeecccddeedcc
-- 051:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 052:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 053:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 054:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 055:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 056:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 057:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 058:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 059:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 060:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 061:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 062:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 063:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 064:dccccccccdccccccccdccccccccdccccccdcdccccdcccdccdcccccdccccccccd
-- 065:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 066:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 067:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 068:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 069:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 070:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 071:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 072:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 073:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 074:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 075:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 076:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 077:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 078:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 079:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 080:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 081:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 082:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 083:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 084:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 085:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 086:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 087:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 088:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 089:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 090:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 091:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 092:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 093:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 094:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 095:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 096:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 097:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 098:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 099:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 100:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 101:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 102:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 103:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 104:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 105:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 106:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 107:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 108:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 109:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 110:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 111:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 112:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 113:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 114:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 115:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 116:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 117:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 118:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 119:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 120:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 121:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 122:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 123:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 124:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 125:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 126:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 127:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 128:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 129:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 130:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 131:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 132:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 133:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 134:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 135:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 136:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 137:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 138:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 139:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 140:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 141:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 142:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 143:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 144:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 145:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 146:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 147:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 148:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 149:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 150:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 151:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 152:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 153:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 154:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 155:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 156:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 157:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 158:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 159:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 160:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 161:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 162:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 163:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 164:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 165:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 166:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 167:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 168:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 169:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 170:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 171:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 172:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 173:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 174:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 175:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 176:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 177:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 178:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 179:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 180:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 181:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 182:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 183:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 184:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 185:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 186:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 187:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 188:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 189:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 190:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 191:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 192:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 193:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 194:ccccc000ccc00ddecc0dccddc0dccccdc0dccccd0eddccdd0eeddddd0eeeddde
-- 195:00cccccce000cccceee00cccdee000ccdeee00ccdeee000ceeee000ceeee000c
-- 196:ccccccccccdcdcdccdcdcdcecdcdcdcecdcccccecdccccdecddccdeeccdddeec
-- 197:ccccccdccccdccccccccccccccdcdcdccdcdcdcecdcdcdcecdcccccecdccccde
-- 198:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 199:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 200:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 201:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 202:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 203:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 204:ccccc000cc000cccc0cc0cddc0cddd00c0cdd0cc0c0e0cdd0ccd0cdd0cdddddd
-- 205:0cccccccc0000cccdcccd0ccdcddd0ccd0d0e0ccdd0ccd0cd0cddd0cdcdddd0c
-- 206:cccccceecccccecdceecceddecd0cecdede0ceddecd0cecdede0ceddecde0ecd
-- 207:ecccccccd0cceecce0cecd0ce0cede0ce0cece0ce0cede0ce0cece0ce0edde0c
-- 208:cccccccccdccccccccccccdccccccccccccccccccccecccccccccccccccccccc
-- 209:cccccccccccccdccccccdccccdccdcccccdcdccdccdcccdccccccccccccccccc
-- 210:00eeeeeec000eeeec0000000ccc00000ccccd0ddcccdd0cdcccd000eccccddd0
-- 211:eee0000c000000cc000000cc0000cccce0dddddce0dddddd000ddddddddddddc
-- 212:cccceccccdcceccdcddcecddcdddedddccdddddccccccccccccdccccccccccdc
-- 213:cddccdeeccdddeeccccceccccdcceccdcddcecddcdddedddccdddddccccccccc
-- 214:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 215:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 216:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 217:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 218:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 219:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 220:0ddd000cc0d0ccd0cc00cdd0cccc000dccccd0ddcccdd0cdcccd000eccccddd0
-- 221:d00ddd0cccd0d0cccdd00ccc000ccccce0dddddce0dddddd000ddddddddddddc
-- 222:edddddddcecdddcdc0eee0ddcce000cdccccceddccdddecdcdddddeecccddddd
-- 223:dddce00cddee00ccee000ccce0cccccce0dddccce0ddddccedddddccdddccccc
-- 224:ccc000ccc00ddd000dd0eee00eed00000ee0ddddee0eeeeeee0eeeeeee0eeeee
-- 225:c0000ccc0dddd00cdeeeeee00eee00e0d0e0dd0ed0edeed0ed0eeed0ed0eeed0
-- 226:dddddddcccccccdcccccccdcccccdddddddddcccccccdcccccccdccccddddccd
-- 227:ccccdccdccccdccdccccddddddccdccdcddddccdcdcccccdcdcccccddddddddd
-- 228:ccccccceccccccdcccccdeccccceccdccccc0ddecedecdedc0cceeddcc0e0dde
-- 229:cccccccc0ccccccccedccccceccecccc0d0cccccdddedecccedcc0ccecee0ccc
-- 230:dcdcdcdccdcdcdcddcdcdcdccdcdcdcddcdcdcdccdcdcdcddcdcdcdccdcdcdcd
-- 231:cccdcccccccdcccccccdccccddddddddcccdcccccccdcccccccdcccccccdcccc
-- 232:ccc00cccccccc0ceccccc0eccccccc0cce0ccc00ccc0cceecccc0cccccce0ccc
-- 233:ccce0ccccce0ccccce0ceeccc00ccccc00cce000e0ce0ccce0c0cccc0000cccc
-- 234:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 235:ccccc0d0ccc0d00ec0d00dcdcc0edcdc0d0dedcdd0eedede00e0ededd00e0e0e
-- 236:d0cccccc00d0cccced00d0ccdede0cccede00d0cdede00dcede0e00c0e0e00dc
-- 237:ccccdcccccccdcccccccdcccccccdcccccdcdcdcccccdcccccccdcccccccdccc
-- 238:cc0000ccc0ccdd0c0cddddd00dd000dd0d0cddd0c0cddd0c0cdd00c00dd0c0d0
-- 239:cc000ccdc0dcc0cc0ddddc0cdd00dd0cdddd0d0c00ddc0cccd0ddc0cdd0ddc0c
-- 240:e000eeee0ddd0eee0eed0eeeceed0eeedeed000ecee0edd0dcd0eed0cdc0eed0
-- 241:ed0eeed0ee0eeeede000eeed0ddd0eed0eed0eeceeee0eedeeee0cdceeeecdcd
-- 242:cdccddddcdcccccdcdcccccdcdccddddddccdccccddddcccccccdcccccccdcdd
-- 243:ccccdcccccccdcccccccdcccddccdccccdccddddcddddccccdccccccdddddccc
-- 244:cceddeddedcddddd0cdde0cdc0ee000ccc00d0d0cccdd0cdcccd000eccccddd0
-- 245:ee0decccddddcdecc0eedc0c000ee0cce0d00ccce0dddddd000ddddddddddddc
-- 246:cccdcccccccdcccccccdccccddddddddcccccccdcccccccdcccccccddddddddd
-- 247:ccddcdcccddcdccccccdccccccddcccccccdcccdcddcccdcddcccdcddccddcdd
-- 248:ccece0c0ccccc000cccccc00ccccccc0cccccc0dcccccd0eccccd000cccccddd
-- 249:0eeeecccee0cceece0cccccce0ccccccee0cccccee0dddcce000dddc0dddddcc
-- 250:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 251:00e0e0e0cd0e0e0ec0d000e0ccc0c000ccccd0d0cccdd0cdcccd000eccccddd0
-- 252:e0e0e00c0e0e0dcce000d0cc00c0cccce0dddddce0dddddd000ddddddddddddc
-- 253:cccccccccddcccddcdddcdddcdddcdddccddeddccccceccccccceccccccccccc
-- 254:0d0c0ccdc0cc0dc0ccc0ccd0cdc0dd0cccc0cc0ccc0ddd0dcc0ccc0ddcc000dd
-- 255:00c0dd0cccc0d0cccccc0cccccdddddcddddddccddddccccddccccdcdcccdccc
-- </TILES>

-- <TILES1>
-- 000:affffffffaffffffffaffffffffaffffffafaffffafffaffafffffaffffffffa
-- 001:aaaaaaaaffaaaffffffaffffffaaafffaaaaaaaaafffffaafffffffaafffffaa
-- 002:a6a6a6a66f6f6a6af6f6a6f66a6a6f6af6f6a6f66f6f6f6af6f6a6f66a6a6a6a
-- 003:aaaaafffaaafffffaaffffffafffffffafffffffffffffffffffffffffffffff
-- 004:fffffffaffffffaafffffaaafffffaaaffffaaaaffffaaaafffaaaaafffaaaaa
-- 005:aaaaafffaaafffffaaffffffafffffffafffffffffffffffffffffffffffffff
-- 006:fffffffaffffffaafffffaaafffffaaaffffaaaaffffaaaafffaaaaafffaaaaa
-- 007:aafffaaffaaffafffaaaffffffaafffaffaaffaaffaafaaafffafaaffffafaaf
-- 008:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 009:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 010:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 011:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 012:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 013:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 014:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 015:fffffffffafffffffffffffffffffafffffffffffffafffffffffffffffffffa
-- 016:fffffffaf6aff6ff6f6f6f6f6fa6af6af6aa6a6fa6aa6a6aaa6a66aafaa66aaf
-- 017:afaf6faffaf6f6faa66af6666fa66ff66aa6aa6ff66a66f6a6fa6af6fa66f66a
-- 018:666a6a6660a6a6606a6a666666a6666606666060666606066666606060666666
-- 019:ffffffffffffffffffffffffffffffaaffffaaaaffaaaaaafaaaaaaaaaaaaaaa
-- 020:ffaaaaaffaaaaaafaaaaaaafaaaaaaffaaaaaaffaaaaafffaaafffffffffffff
-- 021:ffffffffffffffffffffffffffffffaaffffaaaaffaaaaaafaaaaaaaaaaaaaaa
-- 022:ffaaaaaffaaaaaafaaaaaaafaaaaaaffaaaaaaffaaaaafffaaafffffffffffff
-- 023:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 024:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 025:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 026:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 027:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 028:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 029:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 030:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 031:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 032:afafaf00faf000faa60a0aaffa0aaafaa0a060aff06a0a60a006a6a60a6a6a60
-- 033:0fafafaff000fafaaf060faffa6a0afaa6a060af606660faa606006f6060600a
-- 034:fffffffffafffffaffffafffffffffffaffffffffffffffafffffffffaffffff
-- 035:aaaaafffaaafffffaaffffffafffffffafffffffffffffffffffffffffffffff
-- 036:fffffffaffffffaafffffaaafffffaaaffffaaaaffffaaaafffaaaaafffaaaaa
-- 037:aaaaafffaaafffffaaffffffafffffffafffffffffffffffffffffffffffffff
-- 038:fffffffaffffffaafffffaaafffffaaaffffaaaaffffaaaafffaaaaafffaaaaa
-- 039:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 040:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 041:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 042:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 043:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 044:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 045:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 046:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 047:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 048:006666060600666660060606f0606000af000600fa600006afa6606afafa6600
-- 049:0606060f6060660a060600af600060fa000006af60006afaa6066f6f0066fafa
-- 050:ffffff6afffff6f666ff6aa66f6f6a6a6fa6666ff6fa66afaa6a66fffaa66aff
-- 051:ffffffffffffffffffffffffffffffaaffffaaaaffaaaaaafaaaaaaaaaaaaaaa
-- 052:ffaaaaaffaaaaaafaaaaaaafaaaaaaffaaaaaaffaaaaafffaaafffffffffffff
-- 053:ffffffffffffffffffffffffffffffaaffffaaaaffaaaaaafaaaaaaaaaaaaaaa
-- 054:ffaaaaaffaaaaaafaaaaaaafaaaaaaffaaaaaaffaaaaafffaaafffffffffffff
-- 055:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 056:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 057:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 058:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 059:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 060:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 061:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 062:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 063:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 064:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 065:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 066:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 067:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 068:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 069:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 070:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 071:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 072:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 073:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 074:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 075:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 076:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 077:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 078:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 079:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 080:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 081:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 082:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 083:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 084:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 085:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 086:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 087:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 088:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 089:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 090:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 091:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 092:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 093:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 094:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 095:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 096:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 097:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 098:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 099:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 100:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 101:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 102:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 103:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 104:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 105:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 106:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 107:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 108:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 109:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 110:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 111:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 112:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 113:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 114:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 115:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 116:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 117:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 118:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 119:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 120:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 121:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 122:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 123:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 124:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 125:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 126:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 127:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 128:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 129:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 130:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 131:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 132:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 133:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 134:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 135:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 136:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 137:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 138:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 139:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 140:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 141:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 142:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 143:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 144:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 145:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 146:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 147:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 148:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 149:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 150:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 151:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 152:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 153:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 154:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 155:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 156:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 157:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 158:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 159:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 160:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 161:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 162:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 163:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 164:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 165:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 166:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 167:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 168:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 169:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 170:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 171:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 172:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 173:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 174:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 175:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 176:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 177:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 178:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 179:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 180:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 181:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 182:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 183:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 184:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 185:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 186:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 187:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 188:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 189:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 190:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 191:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 192:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 193:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 194:fffff000fff00aa6ff0affaaf0affffaf0affffa06aaffaa066aaaaa0666aaa6
-- 195:00ffffff6000ffff66600fffa66000ffa66600ffa666000f6666000f6666000f
-- 196:ffffffffffafafaffafafaf6fafafaf6fafffff6faffffa6faaffa66ffaaa66f
-- 197:ffffffaffffaffffffffffffffafafaffafafaf6fafafaf6fafffff6faffffa6
-- 198:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 199:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 200:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 201:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 202:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 203:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 204:fffff000ff000ffff0ff0faaf0faaa00f0faa0ff0f060faa0ffa0faa0faaaaaa
-- 205:0ffffffff0000fffafffa0ffafaaa0ffa0a060ffaa0ffa0fa0faaa0fafaaaa0f
-- 206:ffffff66fffff6faf66ff6aa6fa0f6fa6a60f6aa6fa0f6fa6a60f6aa6fa606fa
-- 207:6fffffffa0ff66ff60f6fa0f60f6a60f60f6f60f60f6a60f60f6f60f606aa60f
-- 208:fffffffffaffffffffffffaffffffffffffffffffff6ffffffffffffffffffff
-- 209:fffffffffffffaffffffaffffaffafffffafaffaffafffafffffffffffffffff
-- 210:00666666f0006666f0000000fff00000ffffa0aafffaa0fafffa0006ffffaaa0
-- 211:6660000f000000ff000000ff0000ffff60aaaaaf60aaaaaa000aaaaaaaaaaaaf
-- 212:ffff6ffffaff6ffafaaf6faafaaa6aaaffaaaaaffffffffffffaffffffffffaf
-- 213:faaffa66ffaaa66fffff6ffffaff6ffafaaf6faafaaa6aaaffaaaaafffffffff
-- 214:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 215:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 216:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 217:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 218:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 219:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 220:0aaa000ff0a0ffa0ff00faa0ffff000affffa0aafffaa0fafffa0006ffffaaa0
-- 221:a00aaa0fffa0a0fffaa00fff000fffff60aaaaaf60aaaaaa000aaaaaaaaaaaaf
-- 222:6aaaaaaaf6faaafaf06660aaff6000fafffff6aaffaaa6fafaaaaa66fffaaaaa
-- 223:aaaf600faa6600ff66000fff60ffffff60aaafff60aaaaff6aaaaaffaaafffff
-- 224:fff000fff00aaa000aa06660066a00000660aaaa660666666606666666066666
-- 225:f0000fff0aaaa00fa666666006660060a060aa06a06a66a06a0666a06a0666a0
-- 226:aaaaaaafffffffafffffffafffffaaaaaaaaafffffffafffffffaffffaaaaffa
-- 227:ffffaffaffffaffaffffaaaaaaffaffafaaaaffafafffffafafffffaaaaaaaaa
-- 228:fffffff6ffffffafffffa6fffff6ffafffff0aa6f6a6fa6af0ff66aaff060aa6
-- 229:ffffffff0ffffffff6afffff6ff6ffff0a0fffffaaa6a6fff6aff0ff6f660fff
-- 230:afafafaffafafafaafafafaffafafafaafafafaffafafafaafafafaffafafafa
-- 231:fffafffffffafffffffaffffaaaaaaaafffafffffffafffffffafffffffaffff
-- 232:fff00ffffffff0f6fffff06fffffff0ff60fff00fff0ff66ffff0ffffff60fff
-- 233:fff60fffff60fffff60f66fff00fffff00ff600060f60fff60f0ffff0000ffff
-- 234:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 235:fffff0a0fff0a006f0a00afaff06afaf0a0a6afaa066a6a600606a6aa0060606
-- 236:a0ffffff00a0ffff6a00a0ffa6a60fff6a600a0fa6a600af6a60600f060600af
-- 237:ffffafffffffafffffffafffffffafffffafafafffffafffffffafffffffafff
-- 238:ff0000fff0ffaa0f0faaaaa00aa000aa0a0faaa0f0faaa0f0faa00f00aa0f0a0
-- 239:ff000ffaf0aff0ff0aaaaf0faa00aa0faaaa0a0f00aaf0fffa0aaf0faa0aaf0f
-- 240:600066660aaa0666066a0666f66a0666a66a0006f6606aa0afa066a0faf066a0
-- 241:6a0666a06606666a6000666a0aaa066a066a066f6666066a66660faf6666fafa
-- 242:faffaaaafafffffafafffffafaffaaaaaaffaffffaaaafffffffafffffffafaa
-- 243:ffffafffffffafffffffafffaaffaffffaffaaaafaaaaffffaffffffaaaaafff
-- 244:ff6aa6aa6afaaaaa0faa60faf066000fff00a0a0fffaa0fafffa0006ffffaaa0
-- 245:660a6fffaaaafa6ff066af0f000660ff60a00fff60aaaaaa000aaaaaaaaaaaaf
-- 246:fffafffffffafffffffaffffaaaaaaaafffffffafffffffafffffffaaaaaaaaa
-- 247:ffaafafffaafaffffffaffffffaafffffffafffafaafffafaafffafaaffaafaa
-- 248:ff6f60f0fffff000ffffff00fffffff0ffffff0afffffa06ffffa000fffffaaa
-- 249:06666fff660ff66f60ffffff60ffffff660fffff660aaaff6000aaaf0aaaaaff
-- 250:ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 251:00606060fa060606f0a00060fff0f000ffffa0a0fffaa0fafffa0006ffffaaa0
-- 252:6060600f06060aff6000a0ff00f0ffff60aaaaaf60aaaaaa000aaaaaaaaaaaaf
-- 253:fffffffffaafffaafaaafaaafaaafaaaffaa6aafffff6fffffff6fffffffffff
-- 254:0a0f0ffaf0ff0af0fff0ffa0faf0aa0ffff0ff0fff0aaa0aff0fff0aaff000aa
-- 255:00f0aa0ffff0a0ffffff0fffffaaaaafaaaaaaffaaaaffffaaffffafafffafff
-- </TILES1>

-- <TILES2>
-- 000:dccccccccdccccccccdccccccccdccccccdcdccccdcccdccdcccccdccccccccd
-- 001:ddddddddccdddccccccdccccccdddcccdddddddddcccccddcccccccddcccccdd
-- 002:dedededeececededcecedeceededecedcecedeceecececedcecedeceedededed
-- 003:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 004:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 005:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 006:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 007:ddcccddccddccdcccdddccccccddcccdccddccddccddcdddcccdcddccccdcddc
-- 008:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 009:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 010:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 011:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 012:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 013:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 014:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 015:cccccccccdcccccccccccccccccccdcccccccccccccdcccccccccccccccccccd
-- 016:cccccccdcedcceccecececececdedcedceddedecdeddededddedeeddcddeeddc
-- 017:dcdcecdccdcececddeedceeeecdeecceeddeddecceedeecedecdedcecdeeceed
-- 018:eeededeee0dedee0ededeeeeeedeeeee0eeee0e0eeee0e0eeeeee0e0e0eeeeee
-- 019:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 020:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 021:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 022:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 023:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 024:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 025:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 026:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 027:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 028:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 029:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 030:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 031:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 032:dcdcdc00cdc000cdde0d0ddccd0dddcdd0d0e0dcc0ed0de0d00edede0dedede0
-- 033:0cdcdcdcc000cdcddc0e0cdccded0dcdded0e0dce0eee0cdde0e00ece0e0e00d
-- 034:cccccccccdcccccdccccdcccccccccccdccccccccccccccdcccccccccdcccccc
-- 035:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 036:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 037:dddddcccdddcccccddccccccdcccccccdccccccccccccccccccccccccccccccc
-- 038:cccccccdccccccddcccccdddcccccdddccccddddccccddddcccdddddcccddddd
-- 039:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 040:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 041:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 042:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 043:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 044:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 045:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 046:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 047:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 048:00eeee0e0e00eeeee00e0e0ec0e0e000dc000e00cde0000edcdee0edcdcdee00
-- 049:0e0e0e0ce0e0ee0d0e0e00dce000e0cd00000edce000edcdde0eecec00eecdcd
-- 050:ccccccedccccceceeecceddeececededecdeeeeccecdeedcddedeecccddeedcc
-- 051:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 052:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 053:ccccccccccccccccccccccccccccccddccccddddccddddddcddddddddddddddd
-- 054:ccdddddccddddddcdddddddcddddddccddddddccdddddcccdddccccccccccccc
-- 055:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 056:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 057:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 058:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 059:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 060:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 061:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 062:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 063:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 064:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 065:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 066:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 067:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 068:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 069:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 070:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 071:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 072:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 073:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 074:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 075:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 076:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 077:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 078:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 079:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 080:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 081:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 082:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 083:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 084:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 085:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 086:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 087:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 088:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 089:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 090:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 091:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 092:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 093:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 094:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 095:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 096:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 097:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 098:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 099:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 100:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 101:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 102:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 103:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 104:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 105:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 106:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 107:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 108:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 109:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 110:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 111:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 112:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 113:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 114:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 115:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 116:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 117:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 118:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 119:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 120:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 121:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 122:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 123:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 124:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 125:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 126:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 127:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 128:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 129:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 130:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 131:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 132:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 133:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 134:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 135:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 136:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 137:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 138:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 139:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 140:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 141:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 142:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 143:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 144:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 145:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 146:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 147:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 148:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 149:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 150:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 151:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 152:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 153:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 154:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 155:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 156:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 157:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 158:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 159:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 160:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 161:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 162:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 163:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 164:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 165:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 166:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 167:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 168:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 169:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 170:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 171:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 172:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 173:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 174:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 175:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 176:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 177:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 178:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 179:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 180:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 181:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 182:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 183:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 184:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 185:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 186:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 187:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 188:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 189:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 190:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 191:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 192:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 193:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 194:ccccc000ccc00ddecc0dccddc0dccccdc0dccccd0eddccdd0eeddddd0eeeddde
-- 195:00cccccce000cccceee00cccdee000ccdeee00ccdeee000ceeee000ceeee000c
-- 196:ccccccccccdcdcdccdcdcdcecdcdcdcecdcccccecdccccdecddccdeeccdddeec
-- 197:ccccccdccccdccccccccccccccdcdcdccdcdcdcecdcdcdcecdcccccecdccccde
-- 198:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 199:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 200:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 201:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 202:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 203:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 204:ccccc000cc000cccc0cc0cddc0cddd00c0cdd0cc0c0e0cdd0ccd0cdd0cdddddd
-- 205:0cccccccc0000cccdcccd0ccdcddd0ccd0d0e0ccdd0ccd0cd0cddd0cdcdddd0c
-- 206:cccccceecccccecdceecceddecd0cecdede0ceddecd0cecdede0ceddecde0ecd
-- 207:ecccccccd0cceecce0cecd0ce0cede0ce0cece0ce0cede0ce0cece0ce0edde0c
-- 208:cccccccccdccccccccccccdccccccccccccccccccccecccccccccccccccccccc
-- 209:cccccccccccccdccccccdccccdccdcccccdcdccdccdcccdccccccccccccccccc
-- 210:00eeeeeec000eeeec0000000ccc00000ccccd0ddcccdd0cdcccd000eccccddd0
-- 211:eee0000c000000cc000000cc0000cccce0dddddce0dddddd000ddddddddddddc
-- 212:cccceccccdcceccdcddcecddcdddedddccdddddccccccccccccdccccccccccdc
-- 213:cddccdeeccdddeeccccceccccdcceccdcddcecddcdddedddccdddddccccccccc
-- 214:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 215:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 216:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 217:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 218:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 219:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 220:0ddd000cc0d0ccd0cc00cdd0cccc000dccccd0ddcccdd0cdcccd000eccccddd0
-- 221:d00ddd0cccd0d0cccdd00ccc000ccccce0dddddce0dddddd000ddddddddddddc
-- 222:edddddddcecdddcdc0eee0ddcce000cdccccceddccdddecdcdddddeecccddddd
-- 223:dddce00cddee00ccee000ccce0cccccce0dddccce0ddddccedddddccdddccccc
-- 224:ccc000ccc00ddd000dd0eee00eed00000ee0ddddee0eeeeeee0eeeeeee0eeeee
-- 225:c0000ccc0dddd00cdeeeeee00eee00e0d0e0dd0ed0edeed0ed0eeed0ed0eeed0
-- 226:dddddddcccccccdcccccccdcccccdddddddddcccccccdcccccccdccccddddccd
-- 227:ccccdccdccccdccdccccddddddccdccdcddddccdcdcccccdcdcccccddddddddd
-- 228:ccccccceccccccdcccccdeccccceccdccccc0ddecedecdedc0cceeddcc0e0dde
-- 229:cccccccc0ccccccccedccccceccecccc0d0cccccdddedecccedcc0ccecee0ccc
-- 230:dcdcdcdccdcdcdcddcdcdcdccdcdcdcddcdcdcdccdcdcdcddcdcdcdccdcdcdcd
-- 231:cccdcccccccdcccccccdccccddddddddcccdcccccccdcccccccdcccccccdcccc
-- 232:ccc00cccccccc0ceccccc0eccccccc0cce0ccc00ccc0cceecccc0cccccce0ccc
-- 233:ccce0ccccce0ccccce0ceeccc00ccccc00cce000e0ce0ccce0c0cccc0000cccc
-- 234:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 235:ccccc0d0ccc0d00ec0d00dcdcc0edcdc0d0dedcdd0eedede00e0ededd00e0e0e
-- 236:d0cccccc00d0cccced00d0ccdede0cccede00d0cdede00dcede0e00c0e0e00dc
-- 237:ccccdcccccccdcccccccdcccccccdcccccdcdcdcccccdcccccccdcccccccdccc
-- 238:cc0000ccc0ccdd0c0cddddd00dd000dd0d0cddd0c0cddd0c0cdd00c00dd0c0d0
-- 239:cc000ccdc0dcc0cc0ddddc0cdd00dd0cdddd0d0c00ddc0cccd0ddc0cdd0ddc0c
-- 240:e000eeee0ddd0eee0eed0eeeceed0eeedeed000ecee0edd0dcd0eed0cdc0eed0
-- 241:ed0eeed0ee0eeeede000eeed0ddd0eed0eed0eeceeee0eedeeee0cdceeeecdcd
-- 242:cdccddddcdcccccdcdcccccdcdccddddddccdccccddddcccccccdcccccccdcdd
-- 243:ccccdcccccccdcccccccdcccddccdccccdccddddcddddccccdccccccdddddccc
-- 244:cceddeddedcddddd0cdde0cdc0ee000ccc00d0d0cccdd0cdcccd000eccccddd0
-- 245:ee0decccddddcdecc0eedc0c000ee0cce0d00ccce0dddddd000ddddddddddddc
-- 246:cccdcccccccdcccccccdccccddddddddcccccccdcccccccdcccccccddddddddd
-- 247:ccddcdcccddcdccccccdccccccddcccccccdcccdcddcccdcddcccdcddccddcdd
-- 248:ccece0c0ccccc000cccccc00ccccccc0cccccc0dcccccd0eccccd000cccccddd
-- 249:0eeeecccee0cceece0cccccce0ccccccee0cccccee0dddcce000dddc0dddddcc
-- 250:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 251:00e0e0e0cd0e0e0ec0d000e0ccc0c000ccccd0d0cccdd0cdcccd000eccccddd0
-- 252:e0e0e00c0e0e0dcce000d0cc00c0cccce0dddddce0dddddd000ddddddddddddc
-- 253:cccccccccddcccddcdddcdddcdddcdddccddeddccccceccccccceccccccccccc
-- 254:0d0c0ccdc0cc0dc0ccc0ccd0cdc0dd0cccc0cc0ccc0ddd0dcc0ccc0ddcc000dd
-- 255:00c0dd0cccc0d0cccccc0cccccdddddcddddddccddddccccddccccdcdcccdccc
-- </TILES2>

-- <SPRITES>
-- 000:cccccccccccccccccc00000ccccccc0ccccccc0ccccccc0ccccccc0ccccccccc
-- 001:ccccccccccccccccc000c000ccc0ccc0ccc0ccc0ccc0ccc0ccc0ccc0cccccccc
-- 002:cccccccccccccccccc0ccccccc0ccccccc0ccccccc0cccccccc0000ccccccccc
-- 003:cccccccccccccccccc00000ccc0ccccccc0ccccccc0cccccccc0000ccccccccc
-- 004:ccccccccccccccccc000c000c0ccc0ccc0ccc0ccc0ccc0cccc00cc00cccccccc
-- 005:cccccccccccccccccc00000ccccccc0ccc00000ccc0cccccccc0000ccccccccc
-- 006:cccccccccccccccccc00000ccc0ccc0ccc0ccc0ccc0ccc0ccc00000ccccccccc
-- 007:cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000
-- 016:cccccccccccccccccc0ccc0ccc00000ccc0ccc0ccc0ccc0ccc00000ccccccccc
-- 017:ccccccccccccccccc0c0c0c0c000c000c0c0c0c0c0c0c0c0c000c000cccccccc
-- 018:cccccccccccccccccccc0ccccccc0ccccccc0cccccc0c0cccc0ccc0cc0cccccc
-- 019:cccccccccc0ccccccc0cc0cccc0cc0ccc0c0c0cc0ccc0c0cccc0ccc0cc0ccccc
-- 020:ccccccccccccccccccc000cccc0ccc0ccc0ccc0ccc0ccc0cccc000cccccccccc
-- 021:cccccccccccccccccc00000ccccc0ccccccc0cccccc0c0cccc0ccc0cc0cccccc
-- 022:cccccccc0000cccccc0c0000cc0cc0ccc0c0c0cc0ccc0c0cccc0ccc0cc0ccccc
-- 023:cc000000cc0000000c000000cc000000cc000000cc0000000c000000cc000000
-- 032:ccccccccccc000cccccccccccc00000ccccc0cccccc0c0cccc0ccc0cc0cccccc
-- 033:cccccccccccccccccc00000ccccccc0ccc00000ccccccc0ccccccc0ccccccccc
-- 034:cccccccccccccccccc00000ccccccccccc00000ccc0cccccccc0000ccccccccc
-- 035:cccccccccccccccccc00000cccccccccccc0c0ccccc0c0cccc00000ccccccccc
-- 036:ccccccccccc000cccccccccccc00000cccc000cccc0ccc0ccc0ccc0cccc000cc
-- 037:cccccccccccc0ccccccc0ccccccc0ccccccc000ccccc0ccccccc0ccccccc0ccc
-- 038:cccccccccccccc0cccc0cc0cccc0cc0cccc0cc0cccc0000cccc0cc0cccc0cc0c
-- 039:cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000
-- 048:cccccccccccc0ccccccc0ccccccc000ccccc0ccccccc000ccccc0ccccccc0ccc
-- 049:cccccccccccccc0cccc0cc0cccc0cc0cccc0000cccc0cc0cccc0000cccc0cc0c
-- 050:ccccccccccccc0ccccccc0ccccccc0ccccc000ccccccc0ccccccc0ccccccc0cc
-- 051:ccccccccccccccc0cccc0cc0cccc0cc0cccc0cc0cc000cc0cccc0cc0cccc0cc0
-- 052:ccccccccccccc0ccccccc0ccccc000ccccccc0ccccc000ccccccc0ccccccc0cc
-- 053:ccccccccccccccc0cccc0cc0cccc0cc0cc000cc0cccc0cc0cc000cc0cccc0cc0
-- 054:cccccccccccccccccccccccccccc0ccccccc0cccc0000000cccccccccccccccc
-- 055:cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000
-- 064:ccccccccccccc0ccccccc0cccc0cc0cccc0cc0ccc0000000ccccc0ccccccc0cc
-- 065:ccccccccccccccc0ccccc0c0cc0cc0c0cc0cc0c0c0000000ccccc0c0ccccc0c0
-- 066:ccccccccccccccc0ccccccc0ccc0ccc0ccc0ccc0c0000000ccccccc0ccccccc0
-- 067:ccccccccccccccccccccccccccc0c0ccccc0c0ccc0000000cccccccccccccccc
-- 068:ccccccccccccccccccccccccc0000000ccccc0ccccccc0ccccccc0cccccccccc
-- 069:ccccccccccccccc0ccccccc0ccccccc0c00000c0ccc0ccc0ccc0c000ccccccc0
-- 070:ccccccccccccccc0ccccc0c0ccccc0c0c000c0c0cc0cc0c0cc0c00c0ccccc0c0
-- 071:cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000
-- 080:ccccccccccccccc0ccccccc0ccccccc0c0000000cccc0cc0cccc0cc0ccccccc0
-- 081:ccccccccccccccccccccccccc0000000ccc0cc0cccc0cc0cccc0cc0ccccccccc
-- 082:cccccccccccccccccccccccccccccccccccc00ccccccc0cccccccccccccccccc
-- 083:cccccccccccccc0ccccccc0ccccccc0ccc00cc0cccc0cc0ccccccc0ccccccc0c
-- 084:ccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccc
-- 085:ccccccccccccccc0ccccccc0ccccccc0ccccccc0c0000000ccccccc0ccccccc0
-- 086:cccccccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccccccc0ccc
-- 087:cc000000cc000000cc000000cc000000cc000000cc000000cc000000cc000000
-- 096:cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
-- 097:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 098:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 099:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 100:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 101:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 102:cccccccccccccccc000000000000000000000000000000000000000000000000
-- 103:cc000000cc000000000000000000000000000000000000000000000000000000
-- </SPRITES>

-- <MAP>
-- 004:0000000000000000000000000000000000bece0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:0000000000000000000000000000000000bfcf000000002c3c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:00000000000000ecfc00000000000000000000000000002d3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:00000000000000edfd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:00000002120000000000000000eefe000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:00000003130000000000000000efff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:00000000000000000000000000000000000000000000ccdc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:00000000000000000000000000000000000000000000cddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000000000000004e5e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:000000000000004f5f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <MAP1>
-- 004:0000000000000000000000000000000000bece0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:0000000000000000000000000000000000bfcf000000002c3c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:00000000000000ecfc00000000000000000000000000002d3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:00000000000000edfd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:00000002120000000000000000eefe000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:00000003130000000000000000efff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:00000000000000000000000000000000000000000000ccdc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:00000000000000000000000000000000000000000000cddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000000000000004e5e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:000000000000004f5f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP1>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <SCREEN>
-- 000:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 001:5f5ff5111111115555555555505555555555555555555555555555555555555555055555555555555555555555555505555555555555555055555555550555555555555555505555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 002:5ff5f5111111115500000555505555055555555555555555555555555500000555055555055505555555550000055505555550005555055055500055550555555000555505505550005555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 003:5f55f5111111115555055555505555055555555555555555555555555555550555055555000005555555555555055505555505550555055055055505550555550555055505505505550555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 004:5fff55111111115555055550005555055555555555555555555555555555550555000555055505555555550000055505555505550555055055055505550555550555055505505505550555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 005:555555111111115550505555505555055555555555555555555555555555550555055555055505555555550555555505555505550500055055055505550555550555050005505505550555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 006:555555111111115505550555505555500005555555555555555555555555550555055555000005555555555000055505555550005555055055500055550555555000555505505550005555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 007:555555111111115055555555505555555555555555555555555555555555555555055555555555555555555555555505555555555555055055555555550555555555555505505555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 008:5ccccc11111111ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0c0cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 009:5cccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccc0000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0c0cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 010:5ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000cccccccccccccccccccccccccccccccccccc0000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 011:5ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 012:5ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 013:5ccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 014:5ccccccccccccccccccccccccccccc0cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 015:5ccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 016:55555555cccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 017:55555555ccccccccccccccccccccccc0000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 018:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 019:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 020:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 021:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 022:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 023:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 024:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 025:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 026:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 027:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 028:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 029:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 030:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 031:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 032:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 033:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 034:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 035:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 036:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 037:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 038:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 039:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 040:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 041:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 042:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 043:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 044:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 045:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 046:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 047:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 048:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 049:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 050:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 051:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 052:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 053:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 054:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 055:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 056:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 057:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 058:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 059:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 060:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 061:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 062:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 063:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 064:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 065:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 066:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 067:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 068:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 069:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 070:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 071:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 072:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 073:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 074:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 075:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 076:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 077:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 078:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 079:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 080:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 081:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 082:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 083:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 084:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 085:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 086:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 087:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 088:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 089:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 090:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 091:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 092:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 093:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 094:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 095:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 096:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 097:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 098:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 099:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 100:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfffffcccccffccccffccffffcccfffccfffffcfffffccffccccffccffffcccfffccfffffcfffffccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 101:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffcccccffccccfffcccfffcccccffcffccfcffcccccccffcfffcccfffcccccffcffccfcffcccccccffccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 102:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccccffccccccffccffcfcccfffcccfffccffffccccffcccffccffcfcccfffcccfffccffffccccffcccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 103:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccffcccffccffccfffffcffccccffccfccccffccffccccffccfffffcffccccffccfccccffccffccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 104:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffffcffccccffcffffccccfccfffffccfffccffffccffccccffffccccfccfffffccfffccffffccffcccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 105:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 106:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 107:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 108:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 109:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 110:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccccccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 111:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccccccffccfcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 112:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffffccccccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 113:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfcffcffccfcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 114:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccffccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 115:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 116:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 117:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 118:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 119:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 120:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffcccfffccffffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 121:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccfffccffcffccccffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 122:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccfffcfccfffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 123:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffccffccfcffccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 124:55555555ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccffffccfffccfffffcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 125:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 126:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 127:55555555cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc55555555
-- 128:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 129:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 130:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 131:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 132:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 133:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 134:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- 135:555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
-- </SCREEN>

-- <PALETTE>
-- 000:000000fa00faff0000ff7d04ffff000cfa1038b76404717929366f3b5dc90000ff00fffff4baf494b0c2566c86333c57
-- </PALETTE>

-- <PALETTE1>
-- 000:000000101010202020303030404040505050606060707070808080909090a0a0a0b0b0b0c0c0c0d0d0d0e0e0e0f0f0f0
-- </PALETTE1>

-- <PALETTE2>
-- 000:000000fa00faff0000ff7d04ffff000cfa1038b76404717929366f3b5dc90000ff00fffff4fff494b0c2566c86333c57
-- </PALETTE2>

