try
    % Create a 4-D volume, V, from a set of DICOM files specified by source. 
    % The dicomreadVolume function identifies the correct order of the images and creates a 4-D volume.
    [V,spatial,dim] = dicomreadVolume('./VHF-Head/Head');

    % Use the squeeze function to remove any singleton dimensions.
    volume = squeeze(V);
    % Get the volume dimesnions.
    [x,y,z] = size(volume);

    % Construct empty volumes for the 2 other planes.
    sagittalVol = zeros(x ,z, y);  % x-z Plane
    coronalVol = zeros( y, z, x);  % y-z Plane

    figure('Name', 'Axial Plane');
    for i= 1:z
        % Store axial slices then show.
        imAxial = volume(:,:,i);
        imshow(imAxial,[]); 
    end

    close;
    figure('Name', 'Sagittal Plane');
    for i= 1:y
        % Choose i-th slice in y-axis to be the singleton dimension to get x-z Plane
         % x-z plane now represents the i-th slice in the sagittal volume
        sagittalVol(:,:,i) = squeeze(volume(:,i,:));
        % Store sagittal slices then show.
        imSagittal = sagittalVol(:,:,i);
        imshow(imSagittal,[]);  
    end

    close;
    figure('Name', 'Coronal Plane');
    for i= 1:x 
        % Choose i-th slice in x-axis to be the singleton dimension to get y-z Plane
        % y-z plane now represents the i-th slice in the coronal volume
        coronalVol(:,:,i) = squeeze(volume(i,:,:));
        % Store coronal slices then show.
        imCoronal = coronalVol(:,:,i);
        imshow(imCoronal,[]);   
    end
    close;

catch
    errordlg('Name is non-existent or not a directory','Task 1');
end

