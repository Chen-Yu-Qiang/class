
load('param.mat')

T_c_p2=[cameraParams3d.RotationMatrices(:,:,1),cameraParams3d.TranslationVectors(1,:).';[0,0,0,1]];
T_b_p1=transl(100,400,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,0,100);
T_b_c_1=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)


T_c_p2=[cameraParams3d.RotationMatrices(:,:,2),cameraParams3d.TranslationVectors(2,:).';[0,0,0,1]];
T_b_p1=transl(100,400,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,0,100);
T_b_c_2=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)



T_c_p2=[cameraParams3d.RotationMatrices(:,:,18),cameraParams3d.TranslationVectors(18,:).';[0,0,0,1]];
T_b_p1=transl(300,320,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,0,100);
T_b_c_3=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)



T_c_p2=[cameraParams.RotationMatrices(:,:,1),cameraParams.TranslationVectors(1,:).';[0,0,0,1]];
T_b_p1=transl(100,400,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,-10,100);
T_b_c_1=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)


T_c_p2=[cameraParams.RotationMatrices(:,:,2),cameraParams.TranslationVectors(2,:).';[0,0,0,1]];
T_b_p1=transl(100,400,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,-10,100);
T_b_c_2=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)



T_c_p2=[cameraParams.RotationMatrices(:,:,3),cameraParams.TranslationVectors(3,:).';[0,0,0,1]];
T_b_p1=transl(300,320,145.5)*trotz(135/180*pi)*troty(0)*trotx(pi);
T_p2_p1=transl(188.71,-10,100);
T_b_c_3=T_b_p1*inv(T_p2_p1)*inv(T_c_p2)
