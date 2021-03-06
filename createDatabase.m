function [] = createDatabase()
  [access_images, number_of_access_images] = readAllFromDir('access', 'img/access/', '*.jpg');

  database = zeros(number_of_access_images, 256);
  for i = 1 : number_of_access_images
    img = access_images{i};

    balanced_image = colorCorrection(img);
    face_image = detectFace(balanced_image);

    face_image = rgb2gray(face_image);
    face_image = imresize(face_image, [200, 200]);
    database(i, :) = describe(face_image, 21);
  end

  save src/database.mat database

end
