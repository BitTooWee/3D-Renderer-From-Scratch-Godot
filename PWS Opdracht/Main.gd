extends Control

func Add_Vectors(V1,V2):
	var Result = Vector3(V1.x+V2.x,V1.y+V2.y,V1.z+V2.z)
	return Result

func Dot_Product(V1,V2):
	var Result = V1.x*V2.x + V1.y*V2.y + V1.z*V2.z
	return Result

func Cross_Product(V1,V2):
	var Result = Vector3(V1.y*V2.z-V1.z*V2.y, V1.z*V2.x-V1.x*V2.z, V1.x*V2.y-V1.y*V2.x)
	return Result

func Length_Vector(V1):
	var Result = sqrt(pow(V1.x,2) + pow(V1.y,2) + pow(V1.z,2))
	return Result

func Normalize_Vector(V1):
	var Result = Vector3(V1.x/Length_Vector(V1),V1.y/Length_Vector(V1),V1.z/Length_Vector(V1))
	return Result

var PlayerPosition = Vector3(0,-10,0)
var LightPosition = Vector3(6,0,10)

var X_Rotation = 0.5*PI
var Y_Rotation = 1*PI
var Z_Rotation = 0

var Speed = 5
var velocity = Vector3(0,0,0)
const Gravity = 9.81

var Debug = false

var AtmosphericLighting = 0.25

var CheatPerformanceMode = false
var Resolution = Vector2(256,224)

func MultiplyMatrixwithVector(Vector,Matrix):
	var Result = Vector3(0,0,0)
	Result.x = Vector.x*Matrix[0][0] + Vector.y*Matrix[0][1] + Vector.z*Matrix[0][2] + Matrix[0][3]
	Result.y = Vector.x*Matrix[1][0] + Vector.y*Matrix[1][1] + Vector.z*Matrix[1][2] + Matrix[1][3]
	Result.z = Vector.x*Matrix[2][0] + Vector.y*Matrix[2][1] + Vector.z*Matrix[2][2] + Matrix[2][3]
	var w    = Vector.x*Matrix[3][0] + Vector.y*Matrix[3][1] + Vector.z*Matrix[3][2] + Matrix[3][3]
	if w != 0:
		Result.x = Result.x / w
		Result.y = Result.y / w
		Result.z = Result.z / w
	return Result

func MultiplyMatrixwithMatrix4X4(MatrixA,MatrixB):
	var Result = [
		[MatrixA[0][0]*MatrixB[0][0] + MatrixA[0][1]*MatrixB[1][0] + MatrixA[0][2]*MatrixB[2][0] + MatrixA[0][3]*MatrixB[3][0],MatrixA[0][0]*MatrixB[0][1] + MatrixA[0][1]*MatrixB[1][1] + MatrixA[0][2]*MatrixB[2][1] + MatrixA[0][3]*MatrixB[3][1],MatrixA[0][0]*MatrixB[0][2] + MatrixA[0][1]*MatrixB[1][2] + MatrixA[0][2]*MatrixB[2][2] + MatrixA[0][3]*MatrixB[3][2],MatrixA[0][0]*MatrixB[0][3] + MatrixA[0][1]*MatrixB[1][3] + MatrixA[0][2]*MatrixB[2][3] + MatrixA[0][3]*MatrixB[3][3]],
		[MatrixA[1][0]*MatrixB[0][0] + MatrixA[1][1]*MatrixB[1][0] + MatrixA[1][2]*MatrixB[2][0] + MatrixA[1][3]*MatrixB[3][0],MatrixA[1][0]*MatrixB[0][1] + MatrixA[1][1]*MatrixB[1][1] + MatrixA[1][2]*MatrixB[2][1] + MatrixA[1][3]*MatrixB[3][1],MatrixA[1][0]*MatrixB[0][2] + MatrixA[1][1]*MatrixB[1][2] + MatrixA[1][2]*MatrixB[2][2] + MatrixA[1][3]*MatrixB[3][2],MatrixA[1][0]*MatrixB[0][3] + MatrixA[1][1]*MatrixB[1][3] + MatrixA[1][2]*MatrixB[2][3] + MatrixA[1][3]*MatrixB[3][3]],
		[MatrixA[2][0]*MatrixB[0][0] + MatrixA[2][1]*MatrixB[1][0] + MatrixA[2][2]*MatrixB[2][0] + MatrixA[2][3]*MatrixB[3][0],MatrixA[2][0]*MatrixB[0][1] + MatrixA[2][1]*MatrixB[1][1] + MatrixA[2][2]*MatrixB[2][1] + MatrixA[2][3]*MatrixB[3][1],MatrixA[2][0]*MatrixB[0][2] + MatrixA[2][1]*MatrixB[1][2] + MatrixA[2][2]*MatrixB[2][2] + MatrixA[2][3]*MatrixB[3][2],MatrixA[2][0]*MatrixB[0][3] + MatrixA[2][1]*MatrixB[1][3] + MatrixA[2][2]*MatrixB[2][3] + MatrixA[2][3]*MatrixB[3][3]],
		[MatrixA[3][0]*MatrixB[0][0] + MatrixA[3][1]*MatrixB[1][0] + MatrixA[3][2]*MatrixB[2][0] + MatrixA[3][3]*MatrixB[3][0],MatrixA[3][0]*MatrixB[0][1] + MatrixA[3][1]*MatrixB[1][1] + MatrixA[3][2]*MatrixB[2][1] + MatrixA[3][3]*MatrixB[3][1],MatrixA[3][0]*MatrixB[0][2] + MatrixA[3][1]*MatrixB[1][2] + MatrixA[3][2]*MatrixB[2][2] + MatrixA[3][3]*MatrixB[3][2],MatrixA[3][0]*MatrixB[0][3] + MatrixA[3][1]*MatrixB[1][3] + MatrixA[3][2]*MatrixB[2][3] + MatrixA[3][3]*MatrixB[3][3]]
		
	]
	return Result

#Test code
var Cube = [
	[Vector3(0,0,0),0,0,0,1], #Cube properties, position, xrotation and zrotation
	#North
	[Vector3(1,1,1),Vector3(1,1,-1),Vector3(-1,1,1),Color(1,1,1)],
	[Vector3(-1,1,-1),Vector3(-1,1,1),Vector3(1,1,-1),Color(1,1,1)],
	#South
	[Vector3(1,-1,1),Vector3(-1,-1,1),Vector3(1,-1,-1),Color(1,0,0)],
	[Vector3(-1,-1,-1),Vector3(1,-1,-1),Vector3(-1,-1,1),Color(1,0,0)],
	#East
	[Vector3(1,-1,1),Vector3(1,-1,-1),Vector3(1,1,1),Color(0,1,0)],
	[Vector3(1,1,1),Vector3(1,-1,-1),Vector3(1,1,-1),Color(0,1,0)],
	#West
	[Vector3(-1,-1,1),Vector3(-1,1,1),Vector3(-1,-1,-1),Color(0,0,1)],
	[Vector3(-1,1,1),Vector3(-1,1,-1),Vector3(-1,-1,-1),Color(0,0,1)],
	#Bottom
	[Vector3(-1,-1,-1),Vector3(-1,1,-1),Vector3(1,-1,-1),Color(1,1,0)],
	[Vector3(1,-1,-1),Vector3(-1,1,-1),Vector3(1,1,-1),Color(1,1,0)],
	#Top
	[Vector3(-1,-1,1),Vector3(1,-1,1),Vector3(-1,1,1),Color(0,1,1)],
	[Vector3(1,-1,1),Vector3(1,1,1),Vector3(-1,1,1),Color(0,1,1)],
]

var ObjectList = [
	
]

var RenderList = [
	
]

var DrawList = []

func Load_OBJ(Adress):
	var object = [
		[Vector3(0,0,0),0,0,0,1]
	]
	var f = File.new()
	f.open(Adress, File.READ)
	
	var Vectors = []
	var Colors = [Color(1,1,1)]
	var TriCol = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		var line = f.get_line()
		if line.substr(0, 6) == "usemtl":
			var Mtl = Image.new()
			var index = 0
			var temp_string = ""
			for i in line:
				if index >= 1:
					temp_string += String(i)
				if i == " ":
					index += 1
			Mtl.load("res://Models/" + temp_string + ".png")
			Mtl.lock()
			var pixel = Mtl.get_pixel(1,1)
			Colors.append(pixel)
			TriCol += 1
		if line.substr(0, 1) == "v":
			var index = 0
			var temp_string = ""
			var temp_array = []
			for i in line:
				if i == " ":
					if index > 0:
						temp_array.append(temp_string)
						temp_string = ""
					index +=1
				if index > 0:
					if i != " ":
						temp_string += String(i)
			temp_array.append(temp_string)
			Vectors.append(Vector3(temp_array[0],temp_array[1],temp_array[2]))
		if line.substr(0, 1) == "f":
			var index = 0
			var temp_string = ""
			var temp_array = []
			for i in line:
				if i == " ":
					if index > 0:
						temp_array.append(int(temp_string))
						temp_string = ""
					index +=1
				if index > 0:
					if i != " ":
						temp_string += String(i)
			temp_array.append(int(temp_string))
			if Vectors[int(temp_array[0]) - 1] != Vectors[int(temp_array[1]) - 1] and Vectors[int(temp_array[0]) - 1] != Vectors[int(temp_array[2]) - 1] and Vectors[int(temp_array[1]) - 1] != Vectors[int(temp_array[2]) - 1]:
				object.append([Vectors[int(temp_array[0]) - 1],Vectors[int(temp_array[1]) - 1],Vectors[int(temp_array[2]) - 1],Colors[TriCol]])
	f.close()
	return object

func _ready():
	Resolution = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))
	#loading code
	#ObjectList.append(Load_OBJ("res://Models/Object.txt"))
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ObjectList.append(Cube)

func _input(ev):
	var movement = Vector2(0,0)
	if ev is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			movement += ev.relative
			Input.warp_mouse_position(get_viewport().get_mouse_position()+movement)
			Z_Rotation += 1*(movement.x/Resolution.x)*PI
			X_Rotation += 1*(movement.y/Resolution.y)*PI
			
			X_Rotation = clamp(X_Rotation,-0.0*PI,1.0*PI)

func _process(delta):
	var time_before = OS.get_ticks_msec()
	var total_time = 0
	var frame_time = 0
	get_child(0).text = "FPS " + String(Engine.get_frames_per_second())
	velocity = Vector3(0,0,velocity.z)
	
	if Input.is_key_pressed(KEY_W):
		velocity.x += 1*sin(-1*Z_Rotation)
		velocity.y += 1*cos(-1*Z_Rotation)
	if Input.is_key_pressed(KEY_S):
		velocity.x += -1*sin(-1*Z_Rotation)
		velocity.y += -1*cos(-1*Z_Rotation)
	if Input.is_key_pressed(KEY_A):
		velocity.x += -1*sin(-1*Z_Rotation - 0.5*PI)
		velocity.y += -1*cos(-1*Z_Rotation - 0.5*PI)
	if Input.is_key_pressed(KEY_D):
		velocity.x += -1*sin(-1*Z_Rotation + 0.5*PI)
		velocity.y += -1*cos(-1*Z_Rotation + 0.5*PI)
	if velocity.x != 0 and velocity.y != 0:
		var Velocity_Length = sqrt(pow(velocity.x,2) + pow(velocity.y,2))
		velocity = Vector3((velocity.x/Velocity_Length)*Speed,(velocity.y/Velocity_Length)*Speed,velocity.z)
	
	if Input.is_key_pressed(KEY_SPACE):
		velocity.z = 5
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	velocity.z -= Gravity*delta
	PlayerPosition = Add_Vectors(PlayerPosition, velocity*delta)
	PlayerPosition.z = clamp(PlayerPosition.z,0,1000000)
	if Debug:
		total_time = OS.get_ticks_msec() - time_before - frame_time
		frame_time += OS.get_ticks_msec() - time_before - frame_time
		print("Step 1: Input and movement : Time taken: " + str(total_time))
	
	time += delta
	DrawList = []
	RenderList = []
	
	ObjectList[0][0][0][2] = -3
	ObjectList[0][0][1] = 0.5 * PI
	ObjectList[0][0][2] = 0.5*time #Y-rotation
	ObjectList[0][0][3] = 0.5*time #Z-rotation
	
	#ObjectList[1][0][0][0] = 2*sin(time)
	#ObjectList[1][0][0][1] = 2*cos(time)
	
	for i in ObjectList: #Turn this into object list
		var object = i.duplicate(true)
		var Rotation_Matrix_X = [
			[1,0,0,0],
			[0,cos(object[0][1]),-sin(object[0][1]),0],
			[0,sin(object[0][1]),cos(object[0][1]),0],
			[0,0,0,1]
		]
		var Rotation_Matrix_Y = [
			[cos(object[0][2]),0,sin(object[0][2]),0],
			[0,1,0,0],
			[-sin(object[0][2]),0,cos(object[0][2]),0],
			[0,0,0,1]
		]
		var Rotation_Matrix_Z = [
			[cos(object[0][3]),-sin(object[0][3]),0,0],
			[sin(object[0][3]),cos(object[0][3]),0,0],
			[0,0,1,0],
			[0,0,0,1]
		]
		var Rotation_Matrix = MultiplyMatrixwithMatrix4X4(MultiplyMatrixwithMatrix4X4(Rotation_Matrix_X,Rotation_Matrix_Y),Rotation_Matrix_Z)
		for m in range(object.size() - 1):
			m+=1
			if m == object.size():
				break
			object[m][0] = object[0][4]*object[m][0]
			object[m][1] = object[0][4]*object[m][1]
			object[m][2] = object[0][4]*object[m][2]
			object[m][0] = MultiplyMatrixwithVector(object[m][0],Rotation_Matrix)
			object[m][1] = MultiplyMatrixwithVector(object[m][1],Rotation_Matrix)
			object[m][2] = MultiplyMatrixwithVector(object[m][2],Rotation_Matrix)
		RenderList.append(object)
	if Debug:
		total_time = OS.get_ticks_msec() - time_before - frame_time
		frame_time += OS.get_ticks_msec() - time_before - frame_time
		print("Step 2: Transformations of objects : Time taken: " + str(total_time))
	for j in RenderList: #Turn this into object list
		var object = j.duplicate()
		var Rotation_Matrix_X = [
			[1,0,0,0],
			[0,cos(-1*X_Rotation),-sin(-1*X_Rotation),0],
			[0,sin(-1*X_Rotation),cos(-1*X_Rotation),0],
			[0,0,0,1]
		]
		var Rotation_Matrix_Y = [
			[cos(-1*Y_Rotation),0,sin(-1*Y_Rotation),0],
			[0,1,0,0],
			[-sin(-1*Y_Rotation),0,cos(-1*Y_Rotation),0],
			[0,0,0,1]
		]
		var Rotation_Matrix_Z = [
			[cos(-1*Z_Rotation),-sin(-1*Z_Rotation),0,0],
			[sin(-1*Z_Rotation),cos(-1*Z_Rotation),0,0],
			[0,0,1,0],
			[0,0,0,1]
		]
		var Rotation_Matrix = MultiplyMatrixwithMatrix4X4(MultiplyMatrixwithMatrix4X4(Rotation_Matrix_X,Rotation_Matrix_Y),Rotation_Matrix_Z)
		for i in range(object.size() - 1):
			i+=1
			var MiddleFace = (object[i][0]+object[i][1]+object[i][2] + 3*object[0][0])/3
			
			var VectorAB = object[i][1]-object[i][0]
			var VectorAC = object[i][2]-object[i][0]
			var VectorFace = Cross_Product(VectorAB,VectorAC)
			VectorFace = Normalize_Vector(VectorFace)
			#var DistanceCamera = Projection_Perspective(PlayerPosition-MiddleFace).z
			var DirectionScreen = Dot_Product(VectorFace,Normalize_Vector(PlayerPosition-MiddleFace))
			if DirectionScreen > 0:
				var ColorIntensity = Dot_Product(VectorFace,Normalize_Vector(LightPosition-MiddleFace)) + AtmosphericLighting
				var PosA = MultiplyMatrixwithVector(object[i][0] + object[0][0] - PlayerPosition, Rotation_Matrix)
				var PosB = MultiplyMatrixwithVector(object[i][1] + object[0][0] - PlayerPosition, Rotation_Matrix)
				var PosC = MultiplyMatrixwithVector(object[i][2] + object[0][0] - PlayerPosition, Rotation_Matrix)
				var DistanceCamera = ((PosA + PosB + PosC)/3).z
				if PosA.z < 0 and PosB.z < 0 and PosC.z < 0: #All points are in front of camera
					DrawList.append([PosA,PosB,PosC,ColorIntensity, DistanceCamera, object[i][3],object[6],object[7],object[8]])
	if Debug:
		total_time = OS.get_ticks_msec() - time_before - frame_time
		frame_time += OS.get_ticks_msec() - time_before - frame_time
		print("Step 3: World Rotation : Time taken: " + str(total_time))
	update()
	if Debug:
		total_time = OS.get_ticks_msec() - time_before - frame_time
		frame_time += OS.get_ticks_msec() - time_before - frame_time
		print("Step 4: Rendering : Time taken: " + str(total_time))

func _draw():
	var temparray = []
	var RealDrawList = []
	for j in DrawList.size():
		temparray.append(DrawList[j][4])
	temparray.sort()
	for i in temparray.size():
		for m in DrawList.size():
			if DrawList[m][4] == temparray[i]:
				RealDrawList.append(DrawList[m])
	DrawList = RealDrawList
	
	for j in range(DrawList.size()):
		var PosA = Projection_Perspective(DrawList[j][0])
		var PosB = Projection_Perspective(DrawList[j][1])
		var PosC = Projection_Perspective(DrawList[j][2])
		
		var Pos1 = Vector2((PosA.x + 0.5)*Resolution.x,(PosA.y + 0.5)*Resolution.y)
		var Pos2 = Vector2((PosB.x + 0.5)*Resolution.x,(PosB.y + 0.5)*Resolution.y)
		var Pos3 = Vector2((PosC.x + 0.5)*Resolution.x,(PosC.y + 0.5)*Resolution.y)
		
		if not CheatPerformanceMode:
			if Pos2.y > Pos1.y:
				var temp = Pos1
				Pos1 = Pos2
				Pos2 = temp
			if Pos3.y > Pos2.y:
				var temp = Pos2
				Pos2 = Pos3
				Pos3 = temp
			if Pos2.y > Pos1.y:
				var temp = Pos1
				Pos1 = Pos2
				Pos2 = temp
			var A12 = 0
			var A23 = 0
			var A13 = 0
			if Pos1.x-Pos2.x != 0:
				A12 = (Pos1.y-Pos2.y)/(Pos1.x-Pos2.x)
			if Pos2.x-Pos3.x != 0:
				A23 = (Pos2.y-Pos3.y)/(Pos2.x-Pos3.x)
			if Pos1.x-Pos3.x != 0:
				A13 = (Pos1.y-Pos3.y)/(Pos1.x-Pos3.x)

			var B12 = Pos1.y - A12*Pos1.x
			var B23 = Pos2.y - A23*Pos2.x
			var B13 = Pos3.y - A13*Pos3.x

			var Edge1 = [] 
			var Edge2 = []
			var Edge3 = []
			if A12 != 0:
				for i in Pos1.y-Pos2.y:
					Edge1.append(Vector2(round(((Pos1.y-i)-B12)/A12),round(Pos1.y-i)))
			else:
				for i in Pos1.y-Pos2.y:
					Edge1.append(Vector2(round(Pos1.x),round(Pos1.y-i)))
			if A23 != 0:
				for i in Pos2.y-Pos3.y:
					Edge2.append(Vector2(round(((Pos2.y-i)-B23)/A23),round(Pos2.y-i)))
			else:
				for i in Pos2.y-Pos3.y:
					Edge2.append(Vector2(round(Pos2.x),round(Pos2.y-i)))
			if A13 != 0:
				for i in Pos1.y-Pos3.y:
					Edge3.append(Vector2(round(((Pos1.y-i)-B13)/A13),round(Pos1.y-i)))
			else:
				for i in Pos1.y-Pos3.y:
					Edge3.append(Vector2(round(Pos1.x),round(Pos1.y-i)))
			for i in Edge1.size():
				if Edge1[i].y > 0 and Edge1[i].y <= Resolution.y:
					if Edge1[i].x < 0:
						Edge1[i].x = 0
					elif Edge1[i].x > Resolution.x:
						Edge1[i].x = Resolution.x
					if Edge1[i].y < 0:
						Edge1[i].y = 0
					elif Edge1[i].y > Resolution.y:
						Edge1[i].y = Resolution.y
					if Edge3[i].x < 0:
						Edge3[i].x = 0
					elif Edge3[i].x > Resolution.x:
						Edge3[i].x = Resolution.x
					draw_line(Vector2(Edge1[i].x,Edge1[i].y),Vector2(Edge3[i].x,Edge3[i].y),Color(DrawList[j][3]*DrawList[j][5][0],DrawList[j][3]*DrawList[j][5][1],DrawList[j][3]*DrawList[j][5][2],1))
			for i in Edge2.size():
				if Edge2[i].y > 0 and Edge2[i].y <= Resolution.y:
					if Edge2[i].x < 0:
						Edge2[i].x = 0
					elif Edge2[i].x > Resolution.x:
						Edge2[i].x = Resolution.x
					if Edge3[Edge1.size()+i - 1].x < 0:
						Edge3[Edge1.size()+i - 1].x = 0
					elif Edge3[Edge1.size()+i - 1].x > Resolution.x:
						Edge3[Edge1.size()+i - 1].x = Resolution.x
					draw_line(Vector2(Edge2[i].x,Edge2[i].y),Vector2(Edge3[Edge1.size()+i - 1].x,Edge3[Edge1.size()+ i-1].y),Color(DrawList[j][3]*DrawList[j][5][0],DrawList[j][3]*DrawList[j][5][1],DrawList[j][3]*DrawList[j][5][2],1))
			if Debug:
				draw_line(Pos1,Pos3,Color(0,0,0))
				draw_line(Pos2,Pos1,Color(0,0,0))
				draw_line(Pos3,Pos2,Color(0,0,0))
		else:
			var Colour = PoolColorArray([Color(DrawList[j][3]*DrawList[j][5][0],DrawList[j][3]*DrawList[j][5][1],DrawList[j][3]*DrawList[j][5][2],1)])
			var Positions = [Pos1, Pos2, Pos3]
			draw_polygon(Positions,Colour)
		if j >= DrawList.size() - 1:
			return

var FOV = 0.5 * PI
var time = 0
var Aspectratio = 0.5625
var Focus = 1/(tan(FOV/2)) 
export var Fnear = 1
var Ffar = 10

func Projection_Perspective(Vector):
	var Projection_Matrix = [
		[Aspectratio*Focus,0,0,0],
		[0,Focus,0,0],
		[0,0,Ffar/(Ffar-Fnear),1],
		[0,0,(-Ffar*Fnear)/(Ffar-Fnear),0]
	]
	var Result = MultiplyMatrixwithVector(Vector, Projection_Matrix)
	return Result

func Rotation_X(Vector,degree):
	var Rotation_Matrix = [
		[1,0,0,0],
		[0,cos(degree),-sin(degree),0],
		[0,sin(degree),cos(degree),0],
		[0,0,0,1]
	]
	var Result = MultiplyMatrixwithVector(Vector, Rotation_Matrix)
	return Vector3(Result.x,Result.y,Result.z)

func Rotation_Y(Vector,degree):
	var Rotation_Matrix = [
		[cos(degree),0,sin(degree),0],
		[0,1,0,0],
		[-sin(degree),0,cos(degree),0],
		[0,0,0,1]
	]
	var Result = MultiplyMatrixwithVector(Vector, Rotation_Matrix)
	return Vector3(Result.x,Result.y,Result.z)

func Rotation_Z(Vector,degree):
	var Rotation_Matrix = [
		[cos(degree),-sin(degree),0,0],
		[sin(degree),cos(degree),0,0],
		[0,0,1,0],
		[0,0,0,1]
		]
	var Result = MultiplyMatrixwithVector(Vector, Rotation_Matrix)
	return Vector3(Result.x,Result.y,Result.z)
