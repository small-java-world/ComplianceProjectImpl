-- Add unique constraint to permission_id
ALTER TABLE permission_detail
ADD CONSTRAINT uk_permission_detail_permission_id UNIQUE (permission_id); 