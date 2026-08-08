output "cluster_name" { 
  description = "EKS Cluster Name" 
  value = aws_eks_cluster.cluster.name 
  } 
  
  output "cluster_endpoint" { 
    
    description = "EKS Cluster Endpoint" 
    value = aws_eks_cluster.cluster.endpoint 
    
    } 
    
    output "cluster_certificate_authority_data" { 
      
      description = "EKS Cluster CA Data" 
      value = aws_eks_cluster.cluster.certificate_authority[0].data 
      
      } 

output "cluster_arn" { 
  description = "EKS Cluster ARN" 
  value = aws_eks_cluster.cluster.arn 
  }