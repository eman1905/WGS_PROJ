using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace WGS_PROJ.Models
{
    public partial class WGS_PROJContext : DbContext
    {
        public WGS_PROJContext()
        {
        }

        public WGS_PROJContext(DbContextOptions<WGS_PROJContext> options)
            : base(options)
        {
        }

        public virtual DbSet<MsCourier> MsCourier { get; set; }
        public virtual DbSet<MsProduct> MsProduct { get; set; }
        public virtual DbSet<MsSales> MsSales { get; set; }
        public virtual DbSet<TrInvoice> TrInvoice { get; set; }
        public virtual DbSet<TrInvoiceDetail> TrInvoiceDetail { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();

            optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"),
                opts => opts.CommandTimeout((int)TimeSpan.FromMinutes(2).TotalSeconds));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MsCourier>(entity =>
            {
                entity.HasKey(e => e.CourierId);

                entity.ToTable("msCourier");

                entity.Property(e => e.CourierId).HasColumnName("courier_id");

                entity.Property(e => e.CourierFee)
                    .HasColumnName("courier_fee")
                    .HasColumnType("decimal(18, 2)");

                entity.Property(e => e.CourierName)
                    .HasColumnName("courier_name")
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<MsProduct>(entity =>
            {
                entity.HasKey(e => e.ProductId);

                entity.ToTable("msProduct");

                entity.Property(e => e.ProductId).HasColumnName("product_id");

                entity.Property(e => e.ProductDesc)
                    .HasColumnName("product_desc")
                    .HasMaxLength(1000);

                entity.Property(e => e.ProductPrice)
                    .HasColumnName("product_price")
                    .HasColumnType("decimal(18, 2)");

                entity.Property(e => e.ProductWeight)
                    .HasColumnName("product_weight")
                    .HasColumnType("decimal(18, 2)");
            });

            modelBuilder.Entity<MsSales>(entity =>
            {
                entity.HasKey(e => e.SalesId);

                entity.ToTable("msSales");

                entity.Property(e => e.SalesId).HasColumnName("sales_id");

                entity.Property(e => e.SalesName)
                    .HasColumnName("sales_name")
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<TrInvoice>(entity =>
            {
                entity.HasKey(e => e.InvoiceId);

                entity.ToTable("trInvoice");

                entity.Property(e => e.InvoiceId).HasColumnName("invoice_id");

                entity.Property(e => e.CourierId).HasColumnName("courier_id");

                entity.Property(e => e.InvoiceDate)
                    .HasColumnName("invoice_date")
                    .HasColumnType("date");

                entity.Property(e => e.InvoiceShipTo).HasColumnName("invoice_ship_to");

                entity.Property(e => e.InvoiceTo)
                    .HasColumnName("invoice_to")
                    .HasMaxLength(50);

                entity.Property(e => e.PaymentType)
                    .HasColumnName("payment_type")
                    .HasMaxLength(50);

                entity.Property(e => e.SalesId).HasColumnName("sales_id");

                entity.HasOne(d => d.Courier)
                    .WithMany(p => p.TrInvoice)
                    .HasForeignKey(d => d.CourierId)
                    .HasConstraintName("FK_trInvoice_msCourier");

                entity.HasOne(d => d.Sales)
                    .WithMany(p => p.TrInvoice)
                    .HasForeignKey(d => d.SalesId)
                    .HasConstraintName("FK_trInvoice_msSales");
            });

            modelBuilder.Entity<TrInvoiceDetail>(entity =>
            {
                entity.HasKey(e => e.InvoiceDetailId);

                entity.ToTable("trInvoiceDetail");

                entity.Property(e => e.InvoiceDetailId).HasColumnName("invoice_detail_id");

                entity.Property(e => e.InvoiceId).HasColumnName("invoice_id");

                entity.Property(e => e.ProductId).HasColumnName("product_id");

                entity.Property(e => e.Qty).HasColumnName("qty");

                entity.Property(e => e.TotalPrice)
                    .HasColumnName("total_price")
                    .HasColumnType("decimal(18, 2)");

                entity.Property(e => e.TotalWeight)
                    .HasColumnName("total_weight")
                    .HasColumnType("decimal(18, 2)");

                entity.HasOne(d => d.Invoice)
                    .WithMany(p => p.TrInvoiceDetail)
                    .HasForeignKey(d => d.InvoiceId)
                    .HasConstraintName("FK_trInvoiceDetail_trInvoice");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.TrInvoiceDetail)
                    .HasForeignKey(d => d.ProductId)
                    .HasConstraintName("FK_trInvoiceDetail_msProduct");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
